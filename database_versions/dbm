--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.6
-- Dumped by pg_dump version 9.5.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: answer_details_from_id(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION answer_details_from_id(aid integer) RETURNS TABLE(publicationid integer, body text, questionid integer, title character varying, creation_date timestamp without time zone, solved_date timestamp without time zone, username character varying, userid integer, votes_count bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT answers.publicationid, publications.body, questions.publicationid, questions.title,
    publications.creation_date, answers.solved_date, users.username,users.userid,
    (SELECT COALESCE(SUM(votes.values), 0) FROM votes WHERE votes.publicationid = answers.publicationid) AS votes_count
  FROM answers
    INNER JOIN publications
      ON answers.publicationid = publications.publicationid
    INNER JOIN questions ON answers.questionid = questions.publicationid
    LEFT JOIN users ON publications.userid = users.userid
  WHERE answers.publicationid = aid;
END
$$;


ALTER FUNCTION public.answer_details_from_id(aid integer) OWNER TO luiscosta;

--
-- Name: answer_ranking(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION answer_ranking(aid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE publicationvotecount INTEGER;
BEGIN
  SELECT SUM(votes.values) FROM votes WHERE votes.publicationid = aid
  INTO publicationvotecount;

  IF publicationvotecount is null THEN
    publicationvotecount := 0;
  END IF;

  return publicationvotecount;
END
$$;


ALTER FUNCTION public.answer_ranking(aid integer) OWNER TO luiscosta;

--
-- Name: answer_total_comments(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION answer_total_comments(aid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE questions_count INTEGER;
BEGIN
  SELECT COUNT(*) FROM answers
    INNER JOIN answercomments
      ON answers.publicationid = answercomments.answerid
  WHERE answers.publicationid = aid
  INTO questions_count;

  IF questions_count is null THEN
    questions_count := 0;
  END IF;

  return questions_count;
END
$$;


ALTER FUNCTION public.answer_total_comments(aid integer) OWNER TO luiscosta;

--
-- Name: answers_from_questionid(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION answers_from_questionid(qid integer) RETURNS TABLE(answerid integer, body text, solved_date timestamp without time zone, creation_date timestamp without time zone, userid integer, username character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT answers.publicationid, publications.body, answers.solved_date, publications.creation_date, users.userid, users.username
  FROM publications INNER JOIN answers ON publications.publicationid = answers.publicationid
    LEFT JOIN users ON publications.userid = users.userid
  WHERE answers.questionid = qid;
END
$$;


ALTER FUNCTION public.answers_from_questionid(qid integer) OWNER TO luiscosta;

--
-- Name: category_questions(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION category_questions(skip integer, limitnumber integer, cid integer) RETURNS TABLE(publicationid integer, name character varying, title character varying, body text, creation_date timestamp without time zone, solved_date timestamp without time zone, username character varying, userid integer, answers_count bigint, upvotes bigint, votes_count bigint, views_counter bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT questions.publicationid, categories.name, questions.title, publications.body,
    publications.creation_date, questions.solved_date, users.username, users.userid,
    (SELECT COUNT(*) FROM question_answers(questions.publicationid)) AS answers_count,
    (SELECT COUNT (*) FROM votes WHERE votes.values = 1 AND votes.publicationid = 1) AS upvotes,
    (SELECT SUM(votes.values) FROM votes WHERE votes.publicationid = questions.publicationid),
    questions.views_counter
  FROM questions
    INNER JOIN publications
      ON questions.publicationid = publications.publicationid
    INNER JOIN categories ON questions.categoryid = categories.categoryid
    LEFT JOIN users ON publications.userid = users.userid
  WHERE questions.categoryid = cid
  ORDER BY creation_date DESC
  LIMIT limitNumber
  OFFSET skip;
END
$$;


ALTER FUNCTION public.category_questions(skip integer, limitnumber integer, cid integer) OWNER TO luiscosta;

--
-- Name: count_vote_rating_received_user(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION count_vote_rating_received_user(puser_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE publicationvotecount INTEGER;
BEGIN
  SELECT SUM(votes.values) FROM votes INNER JOIN publications ON votes.publicationid = publications.publicationid
    INNER JOIN users ON publications.userid = users.userid WHERE publications.userid = puser_id
  INTO publicationvotecount;

  IF publicationvotecount is null THEN
    publicationvotecount := 0;
  END IF;

  return publicationvotecount;
END
$$;


ALTER FUNCTION public.count_vote_rating_received_user(puser_id integer) OWNER TO luiscosta;

--
-- Name: delete_question(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION delete_question(qid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE result INTEGER;
begin
  DELETE FROM questions WHERE questions.publicationid = qid;
  DELETE FROM publications WHERE publications.publicationid = qid;
end $$;


ALTER FUNCTION public.delete_question(qid integer) OWNER TO luiscosta;

--
-- Name: delete_solved(integer, integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION delete_solved(aid integer, qid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE result INTEGER;
begin
  UPDATE answers SET solved_date= NULL WHERE publicationid= aid;
  UPDATE questions SET solved_date = NULL WHERE publicationid = qid;
end $$;


ALTER FUNCTION public.delete_solved(aid integer, qid integer) OWNER TO luiscosta;

--
-- Name: get_answer_comments(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION get_answer_comments(aid integer) RETURNS TABLE(questionid integer, answerid integer, publicationid integer, body text, creation_date timestamp without time zone, userid integer, username character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT (SELECT answers.questionid FROM answers WHERE answers.publicationid = aid),
    answercomments.answerid, publications.publicationid, publications.body, publications.creation_date, users.userid, users.username
  FROM answercomments INNER JOIN publications ON answercomments.commentid = publications.publicationid
    LEFT JOIN users ON publications.userid = users.userid
  WHERE answercomments.answerid = aid;
END
$$;


ALTER FUNCTION public.get_answer_comments(aid integer) OWNER TO luiscosta;

--
-- Name: get_publication_rating(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION get_publication_rating(pid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE rating INTEGER;
BEGIN
  SELECT SUM(votes.values) AS rating FROM votes WHERE votes.publicationid = pid
  INTO rating;
  RETURN rating;
END
$$;


ALTER FUNCTION public.get_publication_rating(pid integer) OWNER TO luiscosta;

--
-- Name: get_question_comments(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION get_question_comments(qid integer) RETURNS TABLE(questionid integer, publicationid integer, body text, creation_date timestamp without time zone, userid integer, username character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT questioncomments.questionid, publications.publicationid, publications.body, publications.creation_date, users.userid, users.username
  FROM questioncomments INNER JOIN publications ON questioncomments.commentid = publications.publicationid
    LEFT JOIN users ON publications.userid = users.userid
  WHERE questioncomments.questionid= qid;
END
$$;


ALTER FUNCTION public.get_question_comments(qid integer) OWNER TO luiscosta;

--
-- Name: get_questions_by_user_id(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION get_questions_by_user_id(uid integer, skip integer, limitnumber integer) RETURNS TABLE(publicationid integer, title character varying, body text, creation_date timestamp without time zone, solved_date timestamp without time zone, username character varying, userid integer, answers_count bigint, upvotes bigint, votes_count bigint, views_counter bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT questions.publicationid, questions.title, publications.body,
    publications.creation_date, questions.solved_date, users.username, users.userid,
    (SELECT COUNT(*) FROM question_answers(questions.publicationid)) AS answers_count,
    (SELECT COUNT (*) FROM votes WHERE votes.values = 1 AND votes.publicationid = 1) AS upvotes,
    (SELECT SUM(votes.values) FROM votes WHERE votes.publicationid = questions.publicationid) AS votes_count,
    questions.views_counter
  FROM questions
    INNER JOIN publications
      ON questions.publicationid = publications.publicationid
    LEFT JOIN users ON publications.userid = users.userid
  WHERE users.userid = uid
  LIMIT limitNumber
  OFFSET skip;
END
$$;


ALTER FUNCTION public.get_questions_by_user_id(uid integer, skip integer, limitnumber integer) OWNER TO luiscosta;

--
-- Name: get_questions_from_tagid(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION get_questions_from_tagid(skip integer, limitnumber integer, tid integer) RETURNS TABLE(publicationid integer, title character varying, body text, creation_date timestamp without time zone, solved_date timestamp without time zone, username character varying, userid integer, answers_count bigint, upvotes bigint, votes_count bigint, views_counter bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT questions.publicationid, questions.title, publications.body,
    publications.creation_date, questions.solved_date, users.username, users.userid,
    (SELECT COUNT(*) FROM question_answers(questions.publicationid)) AS answers_count,
    (SELECT COUNT (*) FROM votes WHERE votes.values = 1 AND votes.publicationid = 1) AS upvotes,
    (SELECT SUM(votes.values) FROM votes WHERE votes.publicationid = questions.publicationid),
    questions.views_counter
  FROM questions
    INNER JOIN publications
      ON questions.publicationid = publications.publicationid
    INNER JOIN questiontags ON questions.publicationid = questiontags.questionid
    LEFT JOIN users ON publications.userid = users.userid
  WHERE questiontags.tagid = tid
  LIMIT limitNumber
  OFFSET skip;
END
$$;


ALTER FUNCTION public.get_questions_from_tagid(skip integer, limitnumber integer, tid integer) OWNER TO luiscosta;

--
-- Name: get_users_pag(integer, integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION get_users_pag(skip integer, limitnumber integer) RETURNS TABLE(userid integer, roleid integer, rolename character varying, username character varying, email character varying, bancount bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT users.userid,
    (SELECT userroles.roleid FROM userroles WHERE userroles.roleid = users.roleid),
    (SELECT userroles.rolename FROM userroles WHERE userroles.roleid = users.roleid),
    users.username,
    users.email,
    (SELECT COUNT(*) AS bancount FROM modregisters INNER JOIN bans ON modregisters.modregisterid = bans.banid WHERE userid_target = users.userid)
  FROM users
  ORDER BY userid ASC
  LIMIT limitNumber
  OFFSET skip;
END
$$;


ALTER FUNCTION public.get_users_pag(skip integer, limitnumber integer) OWNER TO luiscosta;

--
-- Name: getusernamefromquestion(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION getusernamefromquestion(questionid integer) RETURNS character varying
    LANGUAGE plpgsql
    AS $_$
BEGIN
  SELECT users.username
  FROM publications
    INNER JOIN questions on publications.publicationid = questions.publicationid
    INNER JOIN users on publications.userid = users.userid
  where questions.publicationid = $1;
END;

$_$;


ALTER FUNCTION public.getusernamefromquestion(questionid integer) OWNER TO luiscosta;

--
-- Name: insert_into_answercomments(integer, integer, text); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION insert_into_answercomments(userid integer, answerid integer, body text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE result INTEGER;
begin
  insert into publications(body, userid)
  VALUES (body, userid)
  returning publications.publicationid AS publicationid INTO result;

  insert into comments(publicationid) VALUES (result);

  insert into answercomments(commentid, answerid) VALUES (result, answerid);
end $$;


ALTER FUNCTION public.insert_into_answercomments(userid integer, answerid integer, body text) OWNER TO luiscosta;

--
-- Name: insert_into_answers(integer, integer, text); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION insert_into_answers(userid integer, questionid integer, body text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE result INTEGER;
begin
  insert into publications(body, userid)
  VALUES (body, userid)
  returning publications.publicationid AS publicationid INTO result;

  insert into answers(publicationid , questionid) VALUES (result, questionid);
end $$;


ALTER FUNCTION public.insert_into_answers(userid integer, questionid integer, body text) OWNER TO luiscosta;

--
-- Name: insert_into_questioncomments(integer, integer, text); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION insert_into_questioncomments(userid integer, questionid integer, body text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE result INTEGER;
BEGIN
  insert into publications(body, userid)
  VALUES (body, userid)
  returning publications.publicationid AS publicationid INTO result;

  insert into comments(publicationid) VALUES (result);

  insert into questioncomments(commentid, questionid) VALUES (result, questionid);
END $$;


ALTER FUNCTION public.insert_into_questioncomments(userid integer, questionid integer, body text) OWNER TO luiscosta;

--
-- Name: insert_into_questions(text, integer, character varying, integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION insert_into_questions(body text, userid integer, title character varying, categoryid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE result INTEGER;
begin
  insert into publications(body, userid)
  VALUES (body, userid)
  returning publications.publicationid AS publicationid INTO result;

  insert into questions(publicationid ,title, categoryid) VALUES (result, title, categoryid);
end $$;


ALTER FUNCTION public.insert_into_questions(body text, userid integer, title character varying, categoryid integer) OWNER TO luiscosta;

--
-- Name: is_answer_accepted(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION is_answer_accepted(aid integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE date_solved TIMESTAMP;
  DECLARE answer_accepted INTEGER;
BEGIN
  SELECT solved_date FROM answers WHERE answers.publicationid = aid
  INTO date_solved;

  IF date_solved is null THEN
    answer_accepted := 0;
  ELSE
    answer_accepted :=1;
  END IF;

  return answer_accepted;
END
$$;


ALTER FUNCTION public.is_answer_accepted(aid integer) OWNER TO luiscosta;

--
-- Name: mark_as_solved(integer, integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION mark_as_solved(aid integer, qid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE result INTEGER;
begin
  UPDATE answers SET solved_date= NOW() WHERE publicationid= aid;
  UPDATE questions SET solved_date = NOW() WHERE publicationid = qid;
end $$;


ALTER FUNCTION public.mark_as_solved(aid integer, qid integer) OWNER TO luiscosta;

--
-- Name: own_content_vote(); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION own_content_vote() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE target_user INTEGER;
BEGIN
  SELECT publications.userid FROM publications INNER JOIN votes ON publications.publicationid = votes.publicationid
  WHERE publications.publicationid = NEW.publicationid INTO target_user;
  IF target_user = NEW.userid THEN
    RAISE EXCEPTION 'You cant vote on your own publications';
  END IF;
  RETURN NULL;
END
$$;


ALTER FUNCTION public.own_content_vote() OWNER TO luiscosta;

--
-- Name: question_answers(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION question_answers(pquestion_id integer) RETURNS TABLE(id integer, user_id integer, username character varying, body text, created_at timestamp without time zone)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT answers.publicationid, users.userid, users.username, publications.body, publications.creation_date
  FROM answers INNER JOIN publications ON answers.publicationid = publications.publicationid
    RIGHT JOIN users ON publications.userid = users.userid
  WHERE answers.questionid = pquestion_id;
END
$$;


ALTER FUNCTION public.question_answers(pquestion_id integer) OWNER TO luiscosta;

--
-- Name: question_details_from_id(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION question_details_from_id(pubid integer) RETURNS TABLE(publicationid integer, title character varying, body text, creation_date timestamp without time zone, solved_date timestamp without time zone, username character varying, userid integer, answers_count bigint, upvotes bigint, down_votes bigint, views_counter bigint, category character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT questions.publicationid,  questions.title, publications.body,
    publications.creation_date, questions.solved_date, users.username,users.userid,
    (SELECT COUNT(*) FROM question_answers(questions.publicationid)) AS answers_count,
    (SELECT COUNT (*) FROM votes WHERE votes.publicationid = pubid AND votes.values = 1) AS upvotes,
    (SELECT COUNT (*) FROM votes WHERE votes.publicationid = pubid AND votes.values = -1) AS down_votes,
    questions.views_counter,
    categories.name
  FROM questions
    INNER JOIN publications
      ON questions.publicationid = publications.publicationid
    INNER JOIN categories ON questions.categoryid = categories.categoryid
    LEFT JOIN users ON publications.userid = users.userid
  WHERE questions.publicationid = pubid;
END
$$;


ALTER FUNCTION public.question_details_from_id(pubid integer) OWNER TO luiscosta;

--
-- Name: question_tags(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION question_tags(pquestion_id integer) RETURNS TABLE(tag character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
  return QUERY
  SELECT tags.name
  FROM tags INNER JOIN questiontags ON tags.tagid = questiontags.tagid
  WHERE questiontags.questionid = pquestion_id;
END
$$;


ALTER FUNCTION public.question_tags(pquestion_id integer) OWNER TO luiscosta;

--
-- Name: recent_questions(integer, integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION recent_questions(skip integer, limitnumber integer) RETURNS TABLE(publicationid integer, title character varying, body text, creation_date timestamp without time zone, solved_date timestamp without time zone, username character varying, userid integer, answers_count bigint, upvotes bigint, votes_count bigint, views_counter bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT questions.publicationid, questions.title, publications.body,
    publications.creation_date, questions.solved_date, users.username, users.userid,
    (SELECT COUNT(*) FROM question_answers(questions.publicationid)) AS answers_count,
    (SELECT COUNT (*) FROM votes WHERE votes.values = 1 AND votes.publicationid = 1) AS upvotes,
    (SELECT SUM(votes.values) FROM votes WHERE votes.publicationid = questions.publicationid),
    questions.views_counter
  FROM questions
    INNER JOIN publications
      ON questions.publicationid = publications.publicationid
    LEFT JOIN users ON publications.userid = users.userid
  ORDER BY creation_date DESC
  LIMIT limitNumber
  OFFSET skip;
END
$$;


ALTER FUNCTION public.recent_questions(skip integer, limitnumber integer) OWNER TO luiscosta;

--
-- Name: related_questions(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION related_questions(cid integer) RETURNS TABLE(publicationid integer, title character varying, body text, creation_date timestamp without time zone, solved_date timestamp without time zone, username character varying, userid integer, answers_count bigint, upvotes bigint, votes_count bigint, views_counter bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT questions.publicationid, questions.title, publications.body,
    publications.creation_date, questions.solved_date, users.username, users.userid,
    (SELECT COUNT(*) FROM question_answers(questions.publicationid)) AS answers_count,
    (SELECT COUNT (*) FROM votes WHERE votes.values = 1 AND votes.publicationid = 1) AS upvotes,
    (SELECT COALESCE(SUM(votes.values), 0) FROM votes WHERE votes.publicationid = questions.publicationid) AS votes_count,
    questions.views_counter
  FROM questions
    INNER JOIN publications
      ON questions.publicationid = publications.publicationid
    LEFT JOIN users ON publications.userid = users.userid
    WHERE questions.categoryid = cid
  ORDER BY votes_count DESC
  LIMIT 5;
END
$$;


ALTER FUNCTION public.related_questions(cid integer) OWNER TO luiscosta;

--
-- Name: related_questions(integer, integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION related_questions(cid integer, qid integer) RETURNS TABLE(publicationid integer, title character varying, body text, creation_date timestamp without time zone, solved_date timestamp without time zone, username character varying, userid integer, answers_count bigint, upvotes bigint, votes_count bigint, views_counter bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT questions.publicationid, questions.title, publications.body,
    publications.creation_date, questions.solved_date, users.username, users.userid,
    (SELECT COUNT(*) FROM question_answers(questions.publicationid)) AS answers_count,
    (SELECT COUNT (*) FROM votes WHERE votes.values = 1 AND votes.publicationid = 1) AS upvotes,
    (SELECT COALESCE(SUM(votes.values), 0) FROM votes WHERE votes.publicationid = questions.publicationid) AS votes_count,
    questions.views_counter
  FROM questions
    INNER JOIN publications
      ON questions.publicationid = publications.publicationid
    LEFT JOIN users ON publications.userid = users.userid
    WHERE questions.categoryid = cid AND questions.publicationid != qid
  ORDER BY votes_count DESC
  LIMIT 5;
END
$$;


ALTER FUNCTION public.related_questions(cid integer, qid integer) OWNER TO luiscosta;

--
-- Name: related_questions(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION related_questions(skip integer, limitnumber integer, cid integer) RETURNS TABLE(publicationid integer, title character varying, body text, creation_date timestamp without time zone, solved_date timestamp without time zone, username character varying, userid integer, answers_count bigint, upvotes bigint, votes_count bigint, views_counter bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT questions.publicationid, questions.title, publications.body,
    publications.creation_date, questions.solved_date, users.username, users.userid,
    (SELECT COUNT(*) FROM question_answers(questions.publicationid)) AS answers_count,
    (SELECT COUNT (*) FROM votes WHERE votes.values = 1 AND votes.publicationid = 1) AS upvotes,
    (SELECT COALESCE(SUM(votes.values), 0) FROM votes WHERE votes.publicationid = questions.publicationid) AS votes_count,
    questions.views_counter
  FROM questions
    INNER JOIN publications
      ON questions.publicationid = publications.publicationid
    LEFT JOIN users ON publications.userid = users.userid
    WHERE questions.categoryid = cid
  ORDER BY votes_count DESC
  LIMIT limitNumber
  OFFSET skip;
END
$$;


ALTER FUNCTION public.related_questions(skip integer, limitnumber integer, cid integer) OWNER TO luiscosta;

--
-- Name: search_answers(text); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION search_answers(psearch text) RETURNS TABLE(answerid integer, score_answer real)
    LANGUAGE plpgsql
    AS $$
BEGIN
  return QUERY
  SELECT publications.publicationid as answers, ts_rank_cd(to_tsvector('english', publications.body),
                                                           plainto_tsquery('english', psearch)) AS score_answer
  FROM publications LEFT OUTER JOIN answers ON publications.publicationid = answers.publicationid
  WHERE to_tsvector('english', publications.body) @@ plainto_tsquery('english', psearch)
  AND answers.publicationid IN (SELECT DISTINCT publications.publicationid as pubs FROM publications
  WHERE to_tsvector('english', publications.body) @@ plainto_tsquery('english', psearch));

END
$$;


ALTER FUNCTION public.search_answers(psearch text) OWNER TO luiscosta;

--
-- Name: search_publications(text); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION search_publications(psearch text) RETURNS TABLE(pid integer, score_pub real)
    LANGUAGE plpgsql
    AS $$
BEGIN
  return QUERY
  SELECT DISTINCT publications.publicationid as pubs, ts_rank_cd(
      to_tsvector('english', publications.body),
      plainto_tsquery('english', psearch)
  ) AS score_pub
  FROM publications
  WHERE to_tsvector('english', publications.body) @@ plainto_tsquery('english', psearch) ;
END
$$;


ALTER FUNCTION public.search_publications(psearch text) OWNER TO luiscosta;

--
-- Name: search_questions(text); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION search_questions(psearch text) RETURNS TABLE(questionid integer, score_question real)
    LANGUAGE plpgsql
    AS $$
BEGIN
  return QUERY
  SELECT DISTINCT questions.publicationid as questions,
                  ts_rank_cd(
                      to_tsvector('english', questions.title),
                      plainto_tsquery('english', psearch)
                  ) AS score_question
  FROM questions
  WHERE to_tsvector('english', questions.title) @@ plainto_tsquery('english', psearch)
        OR questions.publicationid IN (
    SELECT DISTINCT publications.publicationid as pubs
    FROM publications
    WHERE to_tsvector('english', publications.body) @@ plainto_tsquery('english', psearch));
END
$$;


ALTER FUNCTION public.search_questions(psearch text) OWNER TO luiscosta;

--
-- Name: search_tags(text); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION search_tags(psearch text) RETURNS TABLE(tid integer, score_tag real)
    LANGUAGE plpgsql
    AS $$
BEGIN
  return QUERY
  SELECT DISTINCT tags.tagid as pubs, ts_rank_cd(
      to_tsvector('english', tags.name),
      plainto_tsquery('english', psearch)
  ) AS score_pub
  FROM tags
  WHERE to_tsvector('english', tags.name) @@ plainto_tsquery('english', psearch) ;
END
$$;


ALTER FUNCTION public.search_tags(psearch text) OWNER TO luiscosta;

--
-- Name: search_users(text); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION search_users(psearch text) RETURNS TABLE(userid integer, username character varying, score_answer real)
    LANGUAGE plpgsql
    AS $$
BEGIN
  return QUERY
  SELECT users.userid, users.username as users, ts_rank_cd(to_tsvector('english', users.username),
                                                           plainto_tsquery('english', psearch)) AS score_user
  FROM users
  WHERE to_tsvector('english', users.username) @@ plainto_tsquery('english', psearch);
END
$$;


ALTER FUNCTION public.search_users(psearch text) OWNER TO luiscosta;

--
-- Name: top_scored_questions(integer, integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION top_scored_questions(skip integer, limitnumber integer) RETURNS TABLE(publicationid integer, title character varying, body text, creation_date timestamp without time zone, solved_date timestamp without time zone, username character varying, userid integer, answers_count bigint, upvotes bigint, votes_count bigint, views_counter bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT questions.publicationid, questions.title, publications.body,
    publications.creation_date, questions.solved_date, users.username, users.userid,
    (SELECT COUNT(*) FROM question_answers(questions.publicationid)) AS answers_count,
    (SELECT COUNT (*) FROM votes WHERE votes.values = 1 AND votes.publicationid = 1) AS upvotes,
    (SELECT COALESCE(SUM(votes.values), 0) FROM votes WHERE votes.publicationid = questions.publicationid) AS votes_count,
    questions.views_counter
  FROM questions
    INNER JOIN publications
      ON questions.publicationid = publications.publicationid
    LEFT JOIN users ON publications.userid = users.userid
  ORDER BY votes_count DESC
  LIMIT limitNumber
  OFFSET skip;
END
$$;


ALTER FUNCTION public.top_scored_questions(skip integer, limitnumber integer) OWNER TO luiscosta;

--
-- Name: top_scored_users(); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION top_scored_users() RETURNS TABLE(username character varying, count_votes_rating_received integer, count_questions integer, count_answers integer, count_comments integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT users.username,
    count_vote_rating_received_user(users.userid) as total_votes,
    user_total_questions(users.userid) as total_questions,
    user_total_answers(users.userid) as total_answers,
    user_total_comments(users.userid) as total_comments
  FROM votes
    INNER JOIN publications
      ON votes.publicationid = publications.publicationid
    INNER JOIN users
      ON publications.userid = users.userid
  GROUP BY users.userid
  ORDER BY total_votes
  DESC;
END
$$;


ALTER FUNCTION public.top_scored_users() OWNER TO luiscosta;

--
-- Name: trigger_auto_ban_on_warning_limit(); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION trigger_auto_ban_on_warning_limit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF (SELECT COUNT(*)
      FROM modregisters INNER JOIN users ON modregisters.userid_author = users.userid
        INNER JOIN warnings ON modregisters.modregisterid = warnings.warningid
      GROUP BY userid_target) = 3 THEN
    INSERT INTO bans(banid) VALUES(NEW.warningid);
  END IF;
  RETURN NULL;
END;
$$;


ALTER FUNCTION public.trigger_auto_ban_on_warning_limit() OWNER TO luiscosta;

--
-- Name: trigger_update_question_timestamp(); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION trigger_update_question_timestamp() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  new.last_edit_date := now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.trigger_update_question_timestamp() OWNER TO luiscosta;

--
-- Name: unanswered_questions(integer, integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION unanswered_questions(skip integer, limitnumber integer) RETURNS TABLE(publicationid integer, title character varying, body text, creation_date timestamp without time zone, solved_date timestamp without time zone, username character varying, userid integer, answers_count bigint, upvotes bigint, votes_count bigint, views_counter bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT questions.publicationid, questions.title, publications.body,
    publications.creation_date, questions.solved_date, users.username, users.userid,
    (SELECT COUNT(*) FROM question_answers(questions.publicationid)) AS answers_count,
    (SELECT COUNT (*) FROM votes WHERE votes.values = 1 AND votes.publicationid = 1) AS upvotes,
    (SELECT SUM(votes.values) FROM votes WHERE votes.publicationid = questions.publicationid) AS votes_count,
    questions.views_counter
  FROM questions
    INNER JOIN publications
      ON questions.publicationid = publications.publicationid
    LEFT JOIN users ON publications.userid = users.userid
  LIMIT limitNumber
  OFFSET skip;
END
$$;


ALTER FUNCTION public.unanswered_questions(skip integer, limitnumber integer) OWNER TO luiscosta;

--
-- Name: update_question(text, integer, character varying, integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION update_question(body_edited text, questionid integer, title_edited character varying, categoryid_edited integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE result INTEGER;
begin
  UPDATE publications
  SET body = body_edited
  WHERE publications.publicationid = questionid
  returning publications.publicationid AS publicationid INTO result;

  UPDATE questions
  SET title = title_edited, categoryid = categoryid_edited
  WHERE questions.publicationid = questionid;
end $$;


ALTER FUNCTION public.update_question(body_edited text, questionid integer, title_edited character varying, categoryid_edited integer) OWNER TO luiscosta;

--
-- Name: update_user_profile(integer, character varying, character varying, character varying, text); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION update_user_profile(uid integer, full_name character varying, e_mail character varying, location character varying, about_user text) RETURNS void
    LANGUAGE plpgsql
    AS $$
begin
  UPDATE users
  SET fullname = full_name, email = e_mail, about = about_user, locationid = (SELECT locationid FROM locations WHERE locations.name = location)
  WHERE userid = uid;
end $$;


ALTER FUNCTION public.update_user_profile(uid integer, full_name character varying, e_mail character varying, location character varying, about_user text) OWNER TO luiscosta;

--
-- Name: user_badges_ranking(); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION user_badges_ranking() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE target_user INTEGER;
BEGIN
  SELECT publications.userid FROM publications INNER JOIN votes ON publications.publicationid = votes.publicationid
  WHERE publications.publicationid = NEW.publicationid INTO target_user;
  IF count_vote_rating_received_user(target_user) = 1 THEN
    INSERT INTO userbadges(userid, badgeid) VALUES (target_user, 1) ON CONFLICT DO NOTHING;
  END IF;
  IF count_vote_rating_received_user(target_user) = 3 THEN
    INSERT INTO userbadges(userid, badgeid) VALUES (target_user, 2) ON CONFLICT DO NOTHING;
  END IF;
  IF count_vote_rating_received_user(target_user) = 15 THEN
    INSERT INTO userbadges(userid, badgeid) VALUES (target_user, 3) ON CONFLICT DO NOTHING;
  END IF;
  IF count_vote_rating_received_user(target_user) = 30 THEN
    INSERT INTO userbadges(userid, badgeid) VALUES (target_user, 4) ON CONFLICT DO NOTHING;
  END IF;
  IF count_vote_rating_received_user(target_user) = 50 THEN
    INSERT INTO userbadges(userid, badgeid) VALUES (target_user, 5) ON CONFLICT DO NOTHING;
  END IF;
  RETURN NULL;
END
$$;


ALTER FUNCTION public.user_badges_ranking() OWNER TO luiscosta;

--
-- Name: user_profile(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION user_profile(puser_id integer) RETURNS TABLE(fullname character varying, username character varying, email character varying, about character varying, location character varying, role character varying, created_at date, count_votes_rating_received integer, count_questions bigint, count_answers bigint, count_votes_made bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT users.fullname, users.username, users.email, users.about,
    (SELECT locations.name FROM locations WHERE users.locationid = locations.locationid),
    (SELECT rolename FROM users INNER JOIN userroles ON users.roleid = userroles.roleid WHERE userid = puser_id),
    users.signup_date,
    count_vote_rating_received_user(puser_id),
    (SELECT COUNT(*) FROM questions
      INNER JOIN publications
        ON questions.publicationid = publications.publicationid
    WHERE publications.userid = puser_id),
    (SELECT COUNT(*) FROM answers
      INNER JOIN publications
        ON answers.publicationid = publications.publicationid
    WHERE publications.userid = puser_id),
    (SELECT COUNT(*) FROM votes WHERE votes.userid = puser_id)
  FROM users
  WHERE users.userid = puser_id;
END
$$;


ALTER FUNCTION public.user_profile(puser_id integer) OWNER TO luiscosta;

--
-- Name: user_questions(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION user_questions(puser_id integer) RETURNS TABLE(publicationid integer, title character varying, body text, solved_date timestamp without time zone, creation_date timestamp without time zone, last_edit_date timestamp without time zone, count_answers bigint)
    LANGUAGE plpgsql
    AS $$
BEGIN
  RETURN QUERY
  SELECT questions.publicationid, questions.title, publications.body, questions.solved_date, publications.creation_date,
    publications.last_edit_date, (SELECT COUNT(*) FROM answers WHERE questionid = questions.publicationid)
  FROM questions INNER JOIN publications ON questions.publicationid = publications.publicationid
  WHERE publications.userid = puser_id;
END
$$;


ALTER FUNCTION public.user_questions(puser_id integer) OWNER TO luiscosta;

--
-- Name: user_total_answers(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION user_total_answers(puser_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE questions_count INTEGER;
BEGIN
  SELECT COUNT(*) FROM answers
    INNER JOIN publications
      ON answers.publicationid = publications.publicationid
  WHERE publications.userid = puser_id
  INTO questions_count;

  IF questions_count is null THEN
    questions_count := 0;
  END IF;

  return questions_count;
END
$$;


ALTER FUNCTION public.user_total_answers(puser_id integer) OWNER TO luiscosta;

--
-- Name: user_total_comments(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION user_total_comments(puser_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE questions_count INTEGER;
BEGIN
  SELECT COUNT(*) FROM comments
    INNER JOIN publications
      ON comments.publicationid = publications.publicationid
  WHERE publications.userid = puser_id
  INTO questions_count;

  IF questions_count is null THEN
    questions_count := 0;
  END IF;

  return questions_count;
END
$$;


ALTER FUNCTION public.user_total_comments(puser_id integer) OWNER TO luiscosta;

--
-- Name: user_total_questions(integer); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION user_total_questions(puser_id integer) RETURNS integer
    LANGUAGE plpgsql
    AS $$
DECLARE questions_count INTEGER;
BEGIN
  SELECT COUNT(*) FROM questions
    INNER JOIN publications
      ON questions.publicationid = publications.publicationid
  WHERE publications.userid = puser_id
  INTO questions_count;

  IF questions_count is null THEN
    questions_count := 0;
  END IF;

  return questions_count;
END
$$;


ALTER FUNCTION public.user_total_questions(puser_id integer) OWNER TO luiscosta;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: answercomments; Type: TABLE; Schema: public; Owner: luiscosta
--

CREATE TABLE answercomments (
    commentid integer NOT NULL,
    answerid integer NOT NULL
);


ALTER TABLE answercomments OWNER TO luiscosta;

--
-- Name: answercomments_commentid_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE answercomments_commentid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE answercomments_commentid_seq OWNER TO luiscosta;

--
-- Name: answercomments_commentid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE answercomments_commentid_seq OWNED BY answercomments.commentid;


--
-- Name: answers; Type: TABLE; Schema: public; Owner: luiscosta
--

CREATE TABLE answers (
    publicationid integer NOT NULL,
    questionid integer NOT NULL,
    solved_date timestamp without time zone
);


ALTER TABLE answers OWNER TO luiscosta;

--
-- Name: answers_publicationid_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE answers_publicationid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE answers_publicationid_seq OWNER TO luiscosta;

--
-- Name: answers_publicationid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE answers_publicationid_seq OWNED BY answers.publicationid;


--
-- Name: badges; Type: TABLE; Schema: public; Owner: luiscosta
--

CREATE TABLE badges (
    badgeid integer NOT NULL,
    name character varying(50),
    description character varying(100) NOT NULL,
    CONSTRAINT badge_description CHECK (((char_length((description)::text) >= 2) AND (char_length((description)::text) <= 100)))
);


ALTER TABLE badges OWNER TO luiscosta;

--
-- Name: badges_badgeid_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE badges_badgeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE badges_badgeid_seq OWNER TO luiscosta;

--
-- Name: badges_badgeid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE badges_badgeid_seq OWNED BY badges.badgeid;


--
-- Name: bans; Type: TABLE; Schema: public; Owner: luiscosta
--

CREATE TABLE bans (
    banid integer NOT NULL,
    end_date date
);


ALTER TABLE bans OWNER TO luiscosta;

--
-- Name: bans_banid_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE bans_banid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE bans_banid_seq OWNER TO luiscosta;

--
-- Name: bans_banid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE bans_banid_seq OWNED BY bans.banid;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: luiscosta
--

CREATE TABLE categories (
    categoryid integer NOT NULL,
    name character varying(100) NOT NULL,
    CONSTRAINT valid_category CHECK (((char_length((name)::text) >= 3) AND (char_length((name)::text) <= 50)))
);


ALTER TABLE categories OWNER TO luiscosta;

--
-- Name: categories_categoryid_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE categories_categoryid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE categories_categoryid_seq OWNER TO luiscosta;

--
-- Name: categories_categoryid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE categories_categoryid_seq OWNED BY categories.categoryid;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: luiscosta
--

CREATE TABLE comments (
    publicationid integer NOT NULL
);


ALTER TABLE comments OWNER TO luiscosta;

--
-- Name: comments_publicationid_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE comments_publicationid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE comments_publicationid_seq OWNER TO luiscosta;

--
-- Name: comments_publicationid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE comments_publicationid_seq OWNED BY comments.publicationid;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: luiscosta
--

CREATE TABLE locations (
    locationid integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE locations OWNER TO luiscosta;

--
-- Name: locations_locationid_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE locations_locationid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE locations_locationid_seq OWNER TO luiscosta;

--
-- Name: locations_locationid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE locations_locationid_seq OWNED BY locations.locationid;


--
-- Name: modregisters; Type: TABLE; Schema: public; Owner: luiscosta
--

CREATE TABLE modregisters (
    modregisterid integer NOT NULL,
    date_creation timestamp without time zone DEFAULT now() NOT NULL,
    reason character varying(200) NOT NULL,
    userid_author integer NOT NULL,
    userid_target integer NOT NULL
);


ALTER TABLE modregisters OWNER TO luiscosta;

--
-- Name: modregisters_modregisterid_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE modregisters_modregisterid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE modregisters_modregisterid_seq OWNER TO luiscosta;

--
-- Name: modregisters_modregisterid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE modregisters_modregisterid_seq OWNED BY modregisters.modregisterid;


--
-- Name: phinxlog; Type: TABLE; Schema: public; Owner: luiscosta
--

CREATE TABLE phinxlog (
    version bigint NOT NULL,
    migration_name character varying(100),
    start_time timestamp without time zone,
    end_time timestamp without time zone,
    breakpoint boolean DEFAULT false NOT NULL
);


ALTER TABLE phinxlog OWNER TO luiscosta;

--
-- Name: publications; Type: TABLE; Schema: public; Owner: luiscosta
--

CREATE TABLE publications (
    publicationid integer NOT NULL,
    body text NOT NULL,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    userid integer NOT NULL,
    last_edit_date timestamp without time zone,
    CONSTRAINT body_length CHECK (((char_length(body) >= 10) AND (char_length(body) <= 1000)))
);


ALTER TABLE publications OWNER TO luiscosta;

--
-- Name: publications_publicationid_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE publications_publicationid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE publications_publicationid_seq OWNER TO luiscosta;

--
-- Name: publications_publicationid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE publications_publicationid_seq OWNED BY publications.publicationid;


--
-- Name: questioncomments; Type: TABLE; Schema: public; Owner: luiscosta
--

CREATE TABLE questioncomments (
    commentid integer NOT NULL,
    questionid integer NOT NULL
);


ALTER TABLE questioncomments OWNER TO luiscosta;

--
-- Name: questioncomments_commentid_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE questioncomments_commentid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE questioncomments_commentid_seq OWNER TO luiscosta;

--
-- Name: questioncomments_commentid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE questioncomments_commentid_seq OWNED BY questioncomments.commentid;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: luiscosta
--

CREATE TABLE questions (
    publicationid integer NOT NULL,
    title character varying(100) NOT NULL,
    categoryid integer NOT NULL,
    solved_date timestamp without time zone,
    views_counter bigint DEFAULT 0 NOT NULL,
    CONSTRAINT title_length CHECK (((char_length((title)::text) >= 3) AND (char_length((title)::text) <= 50)))
);


ALTER TABLE questions OWNER TO luiscosta;

--
-- Name: questions_publicationid_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE questions_publicationid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE questions_publicationid_seq OWNER TO luiscosta;

--
-- Name: questions_publicationid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE questions_publicationid_seq OWNED BY questions.publicationid;


--
-- Name: questiontags; Type: TABLE; Schema: public; Owner: luiscosta
--

CREATE TABLE questiontags (
    questionid integer NOT NULL,
    tagid integer NOT NULL
);


ALTER TABLE questiontags OWNER TO luiscosta;

--
-- Name: tags; Type: TABLE; Schema: public; Owner: luiscosta
--

CREATE TABLE tags (
    tagid integer NOT NULL,
    name character varying(100) NOT NULL,
    CONSTRAINT valid_tag CHECK (((char_length((name)::text) >= 3) AND (char_length((name)::text) <= 30)))
);


ALTER TABLE tags OWNER TO luiscosta;

--
-- Name: tags_tagid_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE tags_tagid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tags_tagid_seq OWNER TO luiscosta;

--
-- Name: tags_tagid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE tags_tagid_seq OWNED BY tags.tagid;


--
-- Name: userbadges; Type: TABLE; Schema: public; Owner: luiscosta
--

CREATE TABLE userbadges (
    userid integer NOT NULL,
    badgeid integer NOT NULL
);


ALTER TABLE userbadges OWNER TO luiscosta;

--
-- Name: userroles; Type: TABLE; Schema: public; Owner: luiscosta
--

CREATE TABLE userroles (
    roleid integer NOT NULL,
    rolename character varying(50) NOT NULL,
    CONSTRAINT user_role CHECK (((rolename)::text = ANY ((ARRAY['reg'::character varying, 'mod'::character varying, 'admin'::character varying])::text[])))
);


ALTER TABLE userroles OWNER TO luiscosta;

--
-- Name: userroles_roleid_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE userroles_roleid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userroles_roleid_seq OWNER TO luiscosta;

--
-- Name: userroles_roleid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE userroles_roleid_seq OWNED BY userroles.roleid;


--
-- Name: users; Type: TABLE; Schema: public; Owner: luiscosta
--

CREATE TABLE users (
    userid integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(70) NOT NULL,
    password character varying(256) NOT NULL,
    fullname character varying(200),
    about character varying(500),
    website character varying(150),
    signup_date date DEFAULT ('now'::text)::date NOT NULL,
    last_login timestamp without time zone,
    locationid integer,
    roleid integer DEFAULT 1,
    CONSTRAINT valid_date CHECK ((last_login > signup_date)),
    CONSTRAINT valid_email CHECK (((char_length((email)::text) >= 6) AND (char_length((email)::text) <= 50))),
    CONSTRAINT valid_fullname CHECK (((char_length((fullname)::text) >= 6) AND (char_length((fullname)::text) <= 50))),
    CONSTRAINT valid_password CHECK (((char_length((password)::text) >= 6) AND (char_length((password)::text) < 256))),
    CONSTRAINT valid_username CHECK (((char_length((username)::text) >= 1) AND (char_length((username)::text) < 20)))
);


ALTER TABLE users OWNER TO luiscosta;

--
-- Name: users_userid_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE users_userid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_userid_seq OWNER TO luiscosta;

--
-- Name: users_userid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE users_userid_seq OWNED BY users.userid;


--
-- Name: votes; Type: TABLE; Schema: public; Owner: luiscosta
--

CREATE TABLE votes (
    voteid integer NOT NULL,
    "values" integer DEFAULT 0 NOT NULL,
    publicationid integer NOT NULL,
    userid integer NOT NULL,
    CONSTRAINT vote_values CHECK ((("values" = 0) OR ("values" = 1) OR ("values" = '-1'::integer)))
);


ALTER TABLE votes OWNER TO luiscosta;

--
-- Name: votes_voteid_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE votes_voteid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE votes_voteid_seq OWNER TO luiscosta;

--
-- Name: votes_voteid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE votes_voteid_seq OWNED BY votes.voteid;


--
-- Name: warnings; Type: TABLE; Schema: public; Owner: luiscosta
--

CREATE TABLE warnings (
    warningid integer NOT NULL
);


ALTER TABLE warnings OWNER TO luiscosta;

--
-- Name: warnings_warningid_seq; Type: SEQUENCE; Schema: public; Owner: luiscosta
--

CREATE SEQUENCE warnings_warningid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE warnings_warningid_seq OWNER TO luiscosta;

--
-- Name: warnings_warningid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: luiscosta
--

ALTER SEQUENCE warnings_warningid_seq OWNED BY warnings.warningid;


--
-- Name: commentid; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY answercomments ALTER COLUMN commentid SET DEFAULT nextval('answercomments_commentid_seq'::regclass);


--
-- Name: publicationid; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY answers ALTER COLUMN publicationid SET DEFAULT nextval('answers_publicationid_seq'::regclass);


--
-- Name: badgeid; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY badges ALTER COLUMN badgeid SET DEFAULT nextval('badges_badgeid_seq'::regclass);


--
-- Name: banid; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY bans ALTER COLUMN banid SET DEFAULT nextval('bans_banid_seq'::regclass);


--
-- Name: categoryid; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY categories ALTER COLUMN categoryid SET DEFAULT nextval('categories_categoryid_seq'::regclass);


--
-- Name: publicationid; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY comments ALTER COLUMN publicationid SET DEFAULT nextval('comments_publicationid_seq'::regclass);


--
-- Name: locationid; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY locations ALTER COLUMN locationid SET DEFAULT nextval('locations_locationid_seq'::regclass);


--
-- Name: modregisterid; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY modregisters ALTER COLUMN modregisterid SET DEFAULT nextval('modregisters_modregisterid_seq'::regclass);


--
-- Name: publicationid; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY publications ALTER COLUMN publicationid SET DEFAULT nextval('publications_publicationid_seq'::regclass);


--
-- Name: commentid; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY questioncomments ALTER COLUMN commentid SET DEFAULT nextval('questioncomments_commentid_seq'::regclass);


--
-- Name: publicationid; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY questions ALTER COLUMN publicationid SET DEFAULT nextval('questions_publicationid_seq'::regclass);


--
-- Name: tagid; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY tags ALTER COLUMN tagid SET DEFAULT nextval('tags_tagid_seq'::regclass);


--
-- Name: roleid; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY userroles ALTER COLUMN roleid SET DEFAULT nextval('userroles_roleid_seq'::regclass);


--
-- Name: userid; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY users ALTER COLUMN userid SET DEFAULT nextval('users_userid_seq'::regclass);


--
-- Name: voteid; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY votes ALTER COLUMN voteid SET DEFAULT nextval('votes_voteid_seq'::regclass);


--
-- Name: warningid; Type: DEFAULT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY warnings ALTER COLUMN warningid SET DEFAULT nextval('warnings_warningid_seq'::regclass);


--
-- Data for Name: answercomments; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY answercomments (commentid, answerid) FROM stdin;
107	54
\.


--
-- Name: answercomments_commentid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('answercomments_commentid_seq', 1, false);


--
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY answers (publicationid, questionid, solved_date) FROM stdin;
53	19	\N
54	19	\N
60	31	\N
65	27	\N
70	23	\N
116	32	\N
143	141	\N
184	182	\N
185	182	\N
187	186	\N
193	181	\N
\.


--
-- Name: answers_publicationid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('answers_publicationid_seq', 1, false);


--
-- Data for Name: badges; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY badges (badgeid, name, description) FROM stdin;
1	Newbie	New User. No correct answers
2	Starter	Made one question
3	Helper	Answered a topic
4	Loyal	Have one question marked as accepted
5	Master	10 correct answers
\.


--
-- Name: badges_badgeid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('badges_badgeid_seq', 5, true);


--
-- Data for Name: bans; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY bans (banid, end_date) FROM stdin;
24	2017-05-26
57	2017-05-31
\.


--
-- Name: bans_banid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('bans_banid_seq', 1, false);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY categories (categoryid, name) FROM stdin;
1	Sports
2	Industrial
3	Jewelery
4	Baby
5	Grocery
6	Movies
101	Feup
9	Outdoors
10	Electronics
11	Music
12	Kids
13	Home
14	Computers
16	Garden
17	Clothing
20	Tools
27	Toys
32	Automotive
43	Games
44	Books
47	Beauty
53	Shoes
75	Health
\.


--
-- Name: categories_categoryid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('categories_categoryid_seq', 101, true);


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY comments (publicationid) FROM stdin;
81
82
85
86
87
88
89
90
91
92
93
97
100
101
102
104
105
106
107
108
109
110
111
112
118
119
121
123
125
126
127
128
131
132
133
134
136
137
138
139
140
142
146
147
148
149
180
198
\.


--
-- Name: comments_publicationid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('comments_publicationid_seq', 1, false);


--
-- Data for Name: locations; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY locations (locationid, name) FROM stdin;
1	Porto
2	Viseu
3	Sao Paulo
4	Paredes
5	Kamyanyuki
6	Metz
7	Santa Teresa
8	San Julian
9	Blobo
10	Huangzhai
11	Aveleda
12	Wuxiang
13	Yudai
14	Rosebank
15	Onzaga
16	Xiaolin
17	São Miguel do Rio Torto
18	Ash Shuhadā’
19	Breda
20	Kuma
21	Kasungu
22	Jingouhe
23	Lasek
24	Asquipata
25	Longfeng
26	Gaïtánion
27	Perístasi
28	Copa
29	Santuario
30	Orzesze
31	Malhão
32	Oemanu
33	Belén
34	Sumbersewu
35	Jiawu
36	Souto de Cima
37	Ternopil’
38	Shiziqiao
39	Aguelmous
40	Liqiao
41	Sangongqiao
42	Castanheira do Campo
43	Contraalmirante Cordero
44	Buzen
45	Villach
46	Mulhouse
47	Jerez
48	Rājshāhi
49	Thị Trấn Hà Trung
50	Layu
51	Chayuan
52	Laojunmiao
53	Huancapi
54	Potoni
55	Lewo
56	Ystad
57	Encontrados
58	Calilegua
59	Banjar Budakeling
60	Chernyakhovsk
61	Žitenice
62	Palestina de los Altos
63	Dawan
64	Washington
65	Lebak Timur
66	Salon-de-Provence
67	Ribamar
68	Jardim
69	Vysokovsk
70	Humble
71	San Juan de Manapiare
72	Ketapang
73	Timrå
74	Oke Iho
75	Dan Khun Thot
76	Gelin
77	Tianyi
78	Yong’an
79	Jacareí
80	Saint-Denis
81	Grybów
82	Duqu
83	Cova Figueira
84	Shanghudi
85	Zaandam
86	Lincheng
87	Lamadong
88	Jishi
89	Xiaolan
90	Rangpur
91	Penanggal
92	Cagmanaba
93	Madīnat Sittah Uktūbar
94	Azinhal
95	Bangekdewa
96	Pasuruan
97	Baziqiao
98	Sebu
99	Thetford-Mines
100	Mazowe
101	Kalanguy
102	Ivanava
103	Xiangyang
104	Masalovka
105	benfica
106	Santa Cona Assobio
\.


--
-- Name: locations_locationid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('locations_locationid_seq', 106, true);


--
-- Data for Name: modregisters; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY modregisters (modregisterid, date_creation, reason, userid_author, userid_target) FROM stdin;
5	2017-05-23 15:39:25.42196	Just a test	107	7
6	2017-05-23 16:21:38.414601	test	107	5
7	2017-05-23 16:40:07.150602	luis	107	5
8	2017-05-23 16:40:50.789168	test	107	2
9	2017-05-24 10:39:40.459925	Ban test	107	2
10	2017-05-24 10:54:25.939904	teste	107	1
11	2017-05-24 10:57:13.121327	another test	107	2
12	2017-05-24 10:58:25.25482	anotherntest	107	2
13	2017-05-24 10:59:51.107492	dsadasd	107	5
14	2017-05-24 11:01:02.555108	sdjaksdm,sad	107	6
15	2017-05-24 11:27:32.985739	asdajkdms	107	1
16	2017-05-24 11:31:37.580823	asdsak	107	1
17	2017-05-24 11:32:25.819943	asdjsakdm,	107	1
18	2017-05-24 11:32:26.001418	asdjsakdm,	107	1
19	2017-05-24 11:32:26.100296	asdjsakdm,	107	1
20	2017-05-24 11:32:26.144203	asdjsakdm,	107	1
21	2017-05-24 11:32:26.19216	asdjsakdm,	107	2
22	2017-05-24 11:33:15.465175	sksad,a.d	107	1
23	2017-05-24 11:33:51.251122	adksa,mdns	107	2
24	2017-05-24 12:24:17.010627	dsksa,d	107	1
57	2017-05-24 15:11:42.53634	jakdsa,mdh.jsa	107	2
\.


--
-- Name: modregisters_modregisterid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('modregisters_modregisterid_seq', 57, true);


--
-- Data for Name: phinxlog; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY phinxlog (version, migration_name, start_time, end_time, breakpoint) FROM stdin;
20170519201926	MyFirstMigration	2017-05-19 22:22:01	2017-05-19 22:22:01	f
\.


--
-- Data for Name: publications; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY publications (publicationid, body, creation_date, userid, last_edit_date) FROM stdin;
9	Cristiano Ronaldo only thinks about himself	2017-05-17 15:19:46.185236	5	2017-05-17 15:19:46.185236
10	Cristiano Ronaldo carries his National Team	2017-05-17 15:19:46.19971	6	2017-05-17 15:19:46.19971
11	libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla	2017-05-17 15:19:46.220392	96	2017-05-17 15:19:46.220392
13	habitasse platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque	2017-05-17 15:19:46.252359	29	2017-05-17 15:19:46.252359
14	nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc	2017-05-17 15:19:46.281305	97	2017-05-17 15:19:46.281305
16	ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non	2017-05-17 15:19:46.329879	99	2017-05-17 15:19:46.329879
17	vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula	2017-05-17 15:19:46.345923	92	2017-05-17 15:19:46.345923
18	posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi	2017-05-17 15:19:46.366783	61	2017-05-17 15:19:46.366783
19	duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus	2017-05-17 15:19:46.379475	95	2017-05-17 15:19:46.379475
21	adipiscing molestie hendrerit at vulputate vitae nisl aenean lectus pellentesque eget	2017-05-17 15:19:46.418417	45	2017-05-17 15:19:46.418417
22	suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce	2017-05-17 15:19:46.434438	48	2017-05-17 15:19:46.434438
23	tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi	2017-05-17 15:19:46.465673	65	2017-05-17 15:19:46.465673
24	odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec	2017-05-17 15:19:46.481255	67	2017-05-17 15:19:46.481255
25	tempor convallis nulla neque libero convallis eget eleifend luctus ultricies	2017-05-17 15:19:46.498288	86	2017-05-17 15:19:46.498288
26	aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend	2017-05-17 15:19:46.511364	65	2017-05-17 15:19:46.511364
27	scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean	2017-05-17 15:19:46.529664	85	2017-05-17 15:19:46.529664
30	adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam	2017-05-17 15:19:46.605743	19	2017-05-17 15:19:46.605743
31	magna ac consequat metus sapien ut nunc vestibulum ante ipsum	2017-05-17 15:19:46.634966	72	2017-05-17 15:19:46.634966
32	ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac	2017-05-17 15:19:46.657783	18	2017-05-17 15:19:46.657783
35	potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit	2017-05-17 15:19:46.711522	23	2017-05-17 15:19:46.711522
36	lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum	2017-05-17 15:19:46.737315	64	2017-05-17 15:19:46.737315
37	primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus	2017-05-17 15:19:46.755896	61	2017-05-17 15:19:46.755896
38	ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque	2017-05-17 15:19:46.771826	82	2017-05-17 15:19:46.771826
40	arcu libero rutrum ac lobortis vel dapibus at diam nam tristique tortor eu	2017-05-17 15:19:46.864741	19	2017-05-17 15:19:46.864741
42	lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac	2017-05-17 15:19:46.96205	100	2017-05-17 15:19:46.96205
43	nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi	2017-05-17 15:19:47.011015	64	2017-05-17 15:19:47.011015
45	orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a	2017-05-17 15:19:47.064862	70	2017-05-17 15:19:47.064862
46	amet justo morbi ut odio cras mi pede malesuada in imperdiet et	2017-05-17 15:19:47.084415	39	2017-05-17 15:19:47.084415
47	elementum nullam varius nulla facilisi cras non velit nec nisi vulputate	2017-05-17 15:19:47.100466	82	2017-05-17 15:19:47.100466
48	vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque	2017-05-17 15:19:47.118341	10	2017-05-17 15:19:47.118341
51	porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque	2017-05-17 15:19:47.178963	86	2017-05-17 15:19:47.178963
53	orci luctus et ultrices posuere cubilia curae duis faucibus accumsan	2017-05-17 15:19:47.219537	37	2017-05-17 15:19:47.219537
54	ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices	2017-05-17 15:19:47.234316	53	2017-05-17 15:19:47.234316
56	sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam	2017-05-17 15:19:47.278948	25	2017-05-17 15:19:47.278948
58	vestibulum quam sapien varius ut blandit non interdum in ante vestibulum	2017-05-17 15:19:47.317481	83	2017-05-17 15:19:47.317481
60	amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam tristique	2017-05-17 15:19:47.380844	19	2017-05-17 15:19:47.380844
63	nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa	2017-05-17 15:19:47.44511	84	2017-05-17 15:19:47.44511
65	vestibulum sit amet cursus id turpis integer aliquet massa id lobortis	2017-05-17 15:19:47.488775	90	2017-05-17 15:19:47.488775
66	curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat	2017-05-17 15:19:47.511218	60	2017-05-17 15:19:47.511218
68	quis orci eget orci vehicula condimentum curabitur in libero ut	2017-05-17 15:19:47.54165	30	2017-05-17 15:19:47.54165
69	at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat	2017-05-17 15:19:47.557542	81	2017-05-17 15:19:47.557542
70	proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in	2017-05-17 15:19:47.580556	97	2017-05-17 15:19:47.580556
73	gravida sem praesent id massa id nisl venenatis lacinia aenean	2017-05-17 15:19:47.642326	64	2017-05-17 15:19:47.642326
75	lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere	2017-05-17 15:19:47.690427	67	2017-05-17 15:19:47.690427
76	erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla	2017-05-17 15:19:47.712723	89	2017-05-17 15:19:47.712723
79	a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel	2017-05-17 15:19:47.764631	78	2017-05-17 15:19:47.764631
80	euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis	2017-05-17 15:19:47.78497	19	2017-05-17 15:19:47.78497
81	eu massa donec dapibus duis at velit eu est congue elementum in	2017-05-17 15:19:47.806405	28	2017-05-17 15:19:47.806405
82	nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula	2017-05-17 15:19:47.82299	2	2017-05-17 15:19:47.82299
85	ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat	2017-05-17 15:19:47.874442	97	2017-05-17 15:19:47.874442
86	est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum	2017-05-17 15:19:47.889886	30	2017-05-17 15:19:47.889886
87	aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel	2017-05-17 15:19:47.919806	16	2017-05-17 15:19:47.919806
88	accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla	2017-05-17 15:19:47.939834	50	2017-05-17 15:19:47.939834
89	duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate	2017-05-17 15:19:47.954691	9	2017-05-17 15:19:47.954691
90	cursus vestibulum proin eu mi nulla ac enim in tempor turpis	2017-05-17 15:19:47.974975	53	2017-05-17 15:19:47.974975
91	et magnis dis parturient montes nascetur ridiculus mus etiam vel augue	2017-05-17 15:19:47.991758	51	2017-05-17 15:19:47.991758
92	eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat	2017-05-17 15:19:48.016804	47	2017-05-17 15:19:48.016804
93	quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede	2017-05-17 15:19:48.0324	50	2017-05-17 15:19:48.0324
97	pellentesque volutpat dui maecenas tristique est et tempus semper est	2017-05-17 15:19:48.095302	77	2017-05-17 15:19:48.095302
100	purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst	2017-05-17 15:19:48.160152	30	2017-05-17 15:19:48.160152
101	vulputate ut ultrices vel augue vestibulum ante ipsum primis in	2017-05-17 15:19:48.182654	76	2017-05-17 15:19:48.182654
102	sodales sed tincidunt eu felis fusce posuere felis sed lacus	2017-05-17 15:19:48.206276	77	2017-05-17 15:19:48.206276
105	natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque	2017-05-17 15:19:48.25795	9	2017-05-17 15:19:48.25795
106	interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at	2017-05-17 15:19:48.277792	35	2017-05-17 15:19:48.277792
107	nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam	2017-05-17 15:19:48.291517	94	2017-05-17 15:19:48.291517
108	in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet	2017-05-17 15:19:48.315813	21	2017-05-17 15:19:48.315813
109	ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque	2017-05-17 15:19:48.334024	83	2017-05-17 15:19:48.334024
110	augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia	2017-05-17 15:19:48.355433	1	2017-05-17 15:19:48.355433
104	quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh (edited)	2017-05-17 15:19:48.239977	82	2017-05-17 23:59:58.960645
111	Another comment !! (edited part 3)	2017-05-17 22:36:44.91979	107	2017-05-18 08:48:20.699343
112	Another comment part4	2017-05-18 09:00:31.906893	107	2017-05-18 09:00:31.906893
113	this is a category test	2017-05-18 10:16:29.499545	107	2017-05-18 10:16:29.499545
115	<p>Hellosdsadsadas</p>\r\n	2017-05-18 15:05:09.815444	107	2017-05-18 15:05:09.815444
116	<p>Answer number 1</p>\r\n	2017-05-18 15:11:16.1268	107	2017-05-18 15:11:16.1268
118	number 1 lets go\r\n	2017-05-18 15:26:23.755774	107	2017-05-18 15:26:23.755774
119	Comment number 1	2017-05-18 15:26:35.716067	107	2017-05-18 15:26:35.716067
121	Helllooooooooo	2017-05-18 15:27:21.418439	107	2017-05-18 15:27:21.418439
123	nkdlsçkdsald	2017-05-18 15:27:39.751385	107	2017-05-18 15:27:39.751385
124	<p>fdgsdfdsfsdfsd</p>\r\n	2017-05-18 15:32:13.166694	107	2017-05-18 15:32:13.166694
125	dfsdfdfasdsadsadasd	2017-05-18 15:32:23.854264	107	2017-05-18 15:32:23.854264
126	dsadjakdsadksaçldasds	2017-05-18 15:33:08.011458	107	2017-05-18 15:33:08.011458
127	dwdjsaçdklasdsad	2017-05-18 15:33:25.908555	107	2017-05-18 15:33:25.908555
128	Sad little story\r\n	2017-05-18 15:51:26.528779	107	2017-05-18 15:51:26.528779
130	<p>Just a random test</p>\r\n	2017-05-18 15:52:58.338141	107	2017-05-18 15:52:58.338141
132	Helloo youuuuuuu	2017-05-18 16:15:08.849945	107	2017-05-18 16:15:08.849945
133	sajdksadjsadsaçlksadçjdsa	2017-05-18 16:15:54.465004	107	2017-05-18 16:15:54.465004
131	Heloooooo luisaaaaao\r\n	2017-05-18 15:53:08.104475	107	2017-05-18 17:22:50.992856
134	Mas posso comentar, certo?	2017-05-18 17:24:39.830736	108	2017-05-18 17:24:39.830736
136	Hello duuuuuude	2017-05-18 17:29:40.393977	109	2017-05-18 17:29:40.393977
137	dasdkjasddnjlkdsa,dj.ds	2017-05-18 17:30:06.21401	109	2017-05-18 17:30:06.21401
138	OLA O MEU NOME E LUIS	2017-05-18 17:30:26.514956	109	2017-05-18 17:30:26.514956
139	UM COMENTARIOOOOOO	2017-05-18 17:31:17.351011	109	2017-05-18 17:31:17.351011
140	OLAAAAAAAAAAAAAAAAAA	2017-05-18 17:31:30.348722	109	2017-05-18 17:31:30.348722
141	<p>dsajdkslajdsa&ccedil;sadsa</p>\r\n	2017-05-18 17:31:53.191632	109	2017-05-18 17:31:53.191632
142	dsakldçsakdsdçsad	2017-05-18 17:31:57.085578	109	2017-05-18 17:31:57.085578
143	<p>HELOOOOOOOOOOOOOOOOOOOOOOOOASASSADSADASD</p>\r\n	2017-05-18 17:32:10.906918	109	2017-05-18 17:32:10.906918
144	<p>dsajdaksdlsa&ccedil;dsadasdsa&ccedil;ld</p>\r\n	2017-05-18 17:32:33.948421	109	2017-05-18 17:32:33.948421
145	<p>jksjajdksadsadskal</p>\r\n	2017-05-18 17:37:28.499195	109	2017-05-18 17:37:28.499195
146	dsajkdsadjsaçlsa	2017-05-18 17:37:34.495924	109	2017-05-18 17:37:34.495924
147	dsadhjkasjdsdksaçld	2017-05-18 17:37:42.813023	109	2017-05-18 17:37:42.813023
148	ksldsd,sadaldksad	2017-05-18 17:45:30.357423	109	2017-05-18 17:45:30.357423
149	dhsdjksmd,sa.dasdadsa	2017-05-18 17:48:16.207861	109	2017-05-18 17:48:16.207861
150	Hello mariadooo	2017-05-18 19:35:27.596369	109	2017-05-18 19:35:27.596369
180	jakdja,.aç	2017-05-20 02:20:32.787115	109	2017-05-20 02:20:32.787115
184	<p>benfica</p>\r\n	2017-05-21 17:40:37.151075	109	2017-05-21 17:40:37.151075
185	<p>yes, benfica is the actual champion</p>\r\n	2017-05-21 17:58:32.73524	109	2017-05-21 17:58:32.73524
187	<p>The best player from Benfica is Ederson</p>\r\n	2017-05-21 21:02:11.075182	109	2017-05-21 21:02:11.075182
192	<p>test global test</p>\r\n	2017-05-21 22:12:10.551058	109	2017-05-21 22:12:10.551058
182	<p>Is benfica the best portuguese team?</p>\r\n	2017-05-21 17:22:28.288266	109	2017-05-21 22:12:57.083478
181	<p>is feup the best colleage in Portugal?</p>\r\n	2017-05-21 17:18:55.514048	109	2017-05-21 22:14:16.628235
193	<p>feup is the best faculty in portugal</p>\r\n	2017-05-21 22:14:45.668637	109	2017-05-21 22:14:45.668637
194	<p>teste tag test</p>\r\n	2017-05-21 22:17:12.659108	109	2017-05-21 22:57:53.028265
197	<p>footbal test tag</p>\r\n	2017-05-21 22:59:10.637527	109	2017-05-21 22:59:47.330831
186	<p>Who is the best player from the portuguese team, Benfica?</p>\r\n	2017-05-21 20:58:35.630373	109	2017-05-21 23:00:26.352506
198	A test to this tag testi\r\n	2017-05-23 15:54:24.097044	107	2017-05-23 15:54:52.681378
199	<p>What is the best computador these days? Thank you</p>\r\n	2017-05-24 15:46:06.532014	107	2017-05-24 15:58:41.254808
200	<p>What&#39;s the best Quentin Tarantino movie?</p>\r\n	2017-05-24 16:01:48.713289	107	2017-05-24 16:02:58.149342
201	<p>Where can I buy good and cheap clothes?</p>\r\n	2017-05-24 16:05:08.432184	107	2017-05-24 16:05:08.432184
\.


--
-- Name: publications_publicationid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('publications_publicationid_seq', 201, true);


--
-- Data for Name: questioncomments; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY questioncomments (commentid, questionid) FROM stdin;
121	31
127	32
128	32
140	32
142	141
147	21
148	21
149	10
198	197
\.


--
-- Name: questioncomments_commentid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('questioncomments_commentid_seq', 1, true);


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY questions (publicationid, title, categoryid, solved_date, views_counter) FROM stdin;
32	scelerisque Vivamus ridiculus nec	12	\N	19
150	Etiam nostra ridiculus libero cubilia	12	\N	5
19	nonummy inceptos cursus	53	\N	3
23	nostra libero libero nunc ac	2	\N	0
199	What's the best computer these days?	14	\N	9
181	is feup the best engineering colleage?	10	\N	7
10	sollicitudin nec risus	20	\N	4
192	tag global	75	\N	2
200	Best Quentin Tarantino Movie	6	\N	3
21	malesuada interdum Curabitur in massa	1	\N	16
201	Good and cheap clothes	17	\N	1
141	hllloasdsdasda	75	\N	8
27	Etiam malesuada sociosqu fermentum euismod	20	\N	2
194	teste tag test	75	\N	5
182	is benfica the best team in Portugal?	1	\N	18
186	Who is the best player from Benfica?	1	\N	13
197	footbal test tag	75	\N	7
31	tempor cubilia	11	\N	9
\.


--
-- Name: questions_publicationid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('questions_publicationid_seq', 2, true);


--
-- Data for Name: questiontags; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY questiontags (questionid, tagid) FROM stdin;
192	25
186	141
186	142
182	141
182	143
181	144
181	145
194	143
194	145
194	144
197	142
197	144
197	146
197	148
186	146
199	149
200	160
200	161
200	162
201	163
201	164
\.


--
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY tags (tagid, name) FROM stdin;
1	real madrid
2	moon
3	flights
4	pregnancy
5	health
7	matrices
9	Cross-group
10	system-worthy
11	empowering
12	Intuitive
13	benchmark
14	Diverse
15	actuating
16	info-mediaries
18	Decentralized
19	Persevering
20	Graphic Interface
22	Monitored
24	content-based
25	global
26	systemic
27	Persistent
28	full-range
29	Sharable
141	benfica
142	test
143	teste
144	feup
145	colleage
146	football
147	tag
148	tagi
149	champions
150	league
151	league final
154	league finaldsjalkhdasjdsaçlkd
155	sadgasjkdlhadsadoisjaçdlasd
156	sakjdhsajdsakd
158	sajdhsakdsadajkdhad
159	quentin tarantino
160	movie
161	quentin
162	tarantino
163	shopping
164	clothes
\.


--
-- Name: tags_tagid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('tags_tagid_seq', 164, true);


--
-- Data for Name: userbadges; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY userbadges (userid, badgeid) FROM stdin;
45	1
26	1
60	1
18	1
107	1
107	2
109	1
109	2
72	1
19	1
85	1
90	1
\.


--
-- Data for Name: userroles; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY userroles (roleid, rolename) FROM stdin;
1	reg
2	mod
3	admin
\.


--
-- Name: userroles_roleid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('userroles_roleid_seq', 3, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY users (userid, username, email, password, fullname, about, website, signup_date, last_login, locationid, roleid) FROM stdin;
5	member	member@member.pt	12345678	\N	\N	\N	2017-05-17	\N	3	1
6	ronaldo7	ronaldo@ronaldo.pt	12345678	\N	\N	\N	2017-05-17	\N	3	1
7	cfuller0	cwatkins0@disqus.com	eCXLJXL	\N	\N	\N	2017-05-17	\N	73	1
9	dcarter2	sgriffin2@apache.org	X0oACZPB	\N	\N	\N	2017-05-17	\N	43	1
10	mhenry3	sdunn3@forbes.com	NGvubdo	\N	\N	\N	2017-05-17	\N	32	1
11	wgraham4	hsullivan4@dailymail.co.uk	qffCv9	\N	\N	\N	2017-05-17	\N	85	3
12	cgeorge5	sarmstrong5@yale.edu	KMp8oGS	\N	\N	\N	2017-05-17	\N	15	1
14	malexander7	pkelley7@patch.com	mlTSYuE9udF	\N	\N	\N	2017-05-17	\N	30	1
15	estevens8	dyoung8@bing.com	cjKKfUhCq4	\N	\N	\N	2017-05-17	\N	40	1
16	kjackson9	pmcdonald9@marketwatch.com	M7pacvs51	\N	\N	\N	2017-05-17	\N	7	1
19	ckelleyc	flittlec@technorati.com	AokjOQmcrkM	\N	\N	\N	2017-05-17	\N	52	1
25	tjacobsi	rhansoni@psu.edu	988ieJXBJ0uC	\N	\N	\N	2017-05-17	\N	42	1
29	cgardnerm	sortizm@163.com	I4DJvx65	\N	\N	\N	2017-05-17	\N	56	1
32	amarshallp	brichardsonp@altervista.org	BBWjvHZ	\N	\N	\N	2017-05-17	\N	11	1
37	krobertsu	egarciau@businessweek.com	YwG7NNpSHXP0	\N	\N	\N	2017-05-17	\N	15	1
43	sfrazier10	lboyd10@webeden.co.uk	eWKI454L4E	\N	\N	\N	2017-05-17	\N	19	1
44	jhanson11	ecarroll11@slate.com	QiqQulDAKY	\N	\N	\N	2017-05-17	\N	35	1
45	amatthews12	fhanson12@google.de	nuiS8pp	\N	\N	\N	2017-05-17	\N	40	3
46	proberts13	jpayne13@de.vu	3HgIN4av	\N	\N	\N	2017-05-17	\N	15	1
47	ajames14	skelley14@printfriendly.com	ERpBVk4l	\N	\N	\N	2017-05-17	\N	71	1
48	llarson15	jpowell15@microsoft.com	8xSFxIiXkOU	\N	\N	\N	2017-05-17	\N	42	1
50	wwright17	rrogers17@prlog.org	z7phI4jH	\N	\N	\N	2017-05-17	\N	35	1
57	jsmith1e	mbowman1e@homestead.com	SvWTCT2	\N	\N	\N	2017-05-17	\N	89	1
64	jmartin1l	bwatson1l@smugmug.com	kluqiB9C	\N	\N	\N	2017-05-17	\N	30	1
67	dporter1o	bfields1o@senate.gov	iZFTO4u2KCgk	\N	\N	\N	2017-05-17	\N	28	1
76	bthomas1x	jfisher1x@google.co.jp	yamh22QaNhQ	\N	\N	\N	2017-05-17	\N	46	1
77	lallen1y	ccrawford1y@sciencedirect.com	0khnJh	\N	\N	\N	2017-05-17	\N	91	1
78	awarren1z	aanderson1z@arstechnica.com	TQnrVaN	\N	\N	\N	2017-05-17	\N	84	1
83	tclark24	rromero24@w3.org	Ur3ezNVZa	\N	\N	\N	2017-05-17	\N	1	1
84	rcox25	rsullivan25@howstuffworks.com	4NY8kbSO	\N	\N	\N	2017-05-17	\N	66	1
60	gbrown1h	bwalker1h@cnbc.com	NhqOqF	\N	\N	\N	2017-05-17	\N	52	1
61	sharrison1i	etaylor1i@nyu.edu	yJei58AOb	\N	\N	\N	2017-05-17	\N	81	1
62	jaustin1j	mlewis1j@rambler.ru	ZdmbRUY	\N	\N	\N	2017-05-17	\N	70	1
18	mwilliamsb	rreidb@sfgate.com	bu1LzN3bjin1	\N	\N	\N	2017-05-17	\N	16	1
65	jhall1m	pcastillo1m@godaddy.com	hj0ZJsygJ	\N	\N	\N	2017-05-17	\N	87	1
21	vnguyene	bgilberte@xing.com	vdTZ3R28J	\N	\N	\N	2017-05-17	\N	17	1
66	plee1n	mgibson1n@cornell.edu	5GmYA7SKA	\N	\N	\N	2017-05-17	\N	3	1
23	amedinag	aalexanderg@disqus.com	wHc7Q8O	\N	\N	\N	2017-05-17	\N	55	1
26	carmstrongj	jlittlej@shop-pro.jp	V3nxid	\N	\N	\N	2017-05-17	\N	28	1
28	slittlel	efoxl@usatoday.com	727tKDTXU6	\N	\N	\N	2017-05-17	\N	25	1
30	dmeyern	dwashingtonn@e-recht24.de	sStOKsUA	\N	\N	\N	2017-05-17	\N	81	1
34	aroser	rburtonr@pen.io	8wX7HX2FWd	\N	\N	\N	2017-05-17	\N	62	1
35	mriveras	mnicholss@newyorker.com	kfkNCFzL	\N	\N	\N	2017-05-17	\N	58	1
39	aruizw	pweaverw@myspace.com	UFW8qUxR0zvV	\N	\N	\N	2017-05-17	\N	38	1
49	nfowler16	carmstrong16@youku.com	j1TkDtT5GChP	\N	\N	\N	2017-05-17	\N	65	1
51	jmcdonald18	along18@cbslocal.com	L7Hjmlm42	\N	\N	\N	2017-05-17	\N	31	1
53	dyoung1a	bevans1a@cocolog-nifty.com	1b3HaMb	\N	\N	\N	2017-05-17	\N	17	1
54	cwallace1b	jperkins1b@imgur.com	8GaS8Ywe	\N	\N	\N	2017-05-17	\N	79	1
70	gmiller1r	prichardson1r@surveymonkey.com	ju00Q2masJKf	\N	\N	\N	2017-05-17	\N	4	1
72	lkelley1t	ecole1t@goo.gl	QCivhCXGwM0	\N	\N	\N	2017-05-17	\N	83	1
75	jtaylor1w	dlawson1w@marriott.com	KMKp2K3JgO	\N	\N	\N	2017-05-17	\N	70	1
79	rwells20	agreen20@zdnet.com	2pjRjX	\N	\N	\N	2017-05-17	\N	25	1
81	hturner22	ageorge22@slate.com	YGAwbziY2Bg	\N	\N	\N	2017-05-17	\N	10	1
82	fcox23	vmorales23@prweb.com	z9SgT0Q	\N	\N	\N	2017-05-17	\N	43	1
1	editor	editor@editor.pt	12345678	\N	\N	\N	2017-05-17	\N	1	3
2	warneduser	warneduser@user.pt	12345678	\N	\N	\N	2017-05-17	\N	4	2
89	mfisher2a	etaylor2a@bizjournals.com	MGde02	\N	\N	\N	2017-05-17	\N	86	1
92	rduncan2d	dgriffin2d@shop-pro.jp	Oe1a8TM1E4t	\N	\N	\N	2017-05-17	\N	30	1
94	ljones2f	bstanley2f@indiegogo.com	XGMgcn7gZ9j	\N	\N	\N	2017-05-17	\N	13	1
96	sjohnson2h	revans2h@discuz.net	rmy4ZkCO9b	\N	\N	\N	2017-05-17	\N	92	1
111	admin 	admin@admin.pt	$2y$10$uS9AfkOEvgD5wYCdfr0b6eIDut3olhWwyvtIfqyHtRmFPY098urMW	\N	\N	\N	2017-05-23	\N	\N	1
109	reverse	reverse@reverse.pt	$2y$10$izRl9uggZAtnFIzdzuv.ee.3H34GBXBlwlilLI7jSBvsXva1lLh2G	\N	\N	\N	2017-05-18	\N	\N	3
85	scarpenter26	jgilbert26@wordpress.org	Ri4qBabTeLB	\N	\N	\N	2017-05-17	\N	59	1
86	fwallace27	dray27@squidoo.com	MClUXQL51e	\N	\N	\N	2017-05-17	\N	61	1
90	rpierce2b	ktaylor2b@aol.com	nzQVDKVsxpxi	\N	\N	\N	2017-05-17	\N	34	1
95	mlynch2g	wpalmer2g@globo.com	UKS1gx	\N	\N	\N	2017-05-17	\N	84	1
97	gmorris2i	sjackson2i@sfgate.com	iItAGleErkye	\N	\N	\N	2017-05-17	\N	9	1
99	ralvarez2k	tjordan2k@bluehost.com	R6iqI5pEeZ	\N	\N	\N	2017-05-17	\N	26	1
100	crobinson2l	ngonzales2l@bigcartel.com	yMPDBniqW1	\N	\N	\N	2017-05-17	\N	81	1
101	rstone2m	sgriffin2m@vinaora.com	LNB4sGg	\N	\N	\N	2017-05-17	\N	36	1
102	kgreen2n	rcooper2n@reddit.com	UVeFJ95	\N	\N	\N	2017-05-17	\N	71	1
103	abutler2o	cgrant2o@howstuffworks.com	elKmKGK	\N	\N	\N	2017-05-17	\N	2	1
105	jwatson2q	dharrison2q@craigslist.org	QEOV6XOVqu	\N	\N	\N	2017-05-17	\N	61	1
106	aholmes2r	wlewis2r@mediafire.com	wLe1ZIe7s	\N	\N	\N	2017-05-17	\N	79	1
108	luiscosta	luistelmocosta@gmail.com	$2y$10$25xpBvgTcb04bZZU8ybva.NuVfCH2kfb/hpC.WgCJ8fVKzUSpKqY6	\N	\N	\N	2017-05-18	\N	\N	2
110	admin	admin@admin.pt	$2y$10$pWkUMUCAaGWTIF..T1azde7rpf5lQiCtXRCSAf1nqnG2AsBsyCdNq	\N	\N	\N	2017-05-23	\N	\N	3
107	benfica	benfica@benfica.pt	$2y$10$6BzpAt3yQ36nyjU8er9B5uL1zO.Wr2tVW/XOuHShAIlPRDJcupcQG	\N	\N	\N	2017-05-17	\N	106	3
\.


--
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('users_userid_seq', 111, true);


--
-- Data for Name: votes; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY votes (voteid, "values", publicationid, userid) FROM stdin;
9	1	21	2
10	1	21	1
20	-1	21	7
21	-1	23	7
25	1	66	107
27	1	32	107
29	1	130	108
31	1	124	108
33	1	150	107
34	1	141	107
35	1	143	107
37	1	144	107
41	1	31	107
42	1	60	107
44	1	27	107
45	1	65	107
48	1	31	109
49	1	60	109
51	1	32	109
\.


--
-- Name: votes_voteid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('votes_voteid_seq', 52, true);


--
-- Data for Name: warnings; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY warnings (warningid) FROM stdin;
\.


--
-- Name: warnings_warningid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('warnings_warningid_seq', 1, false);


--
-- Name: answercomments_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY answercomments
    ADD CONSTRAINT answercomments_pkey PRIMARY KEY (commentid);


--
-- Name: answers_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT answers_pkey PRIMARY KEY (publicationid);


--
-- Name: badges_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY badges
    ADD CONSTRAINT badges_pkey PRIMARY KEY (badgeid);


--
-- Name: bans_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY bans
    ADD CONSTRAINT bans_pkey PRIMARY KEY (banid);


--
-- Name: categories_name_key; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_name_key UNIQUE (name);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (categoryid);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (publicationid);


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (locationid);


--
-- Name: modregisters_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY modregisters
    ADD CONSTRAINT modregisters_pkey PRIMARY KEY (modregisterid);


--
-- Name: phinxlog_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY phinxlog
    ADD CONSTRAINT phinxlog_pkey PRIMARY KEY (version);


--
-- Name: publications_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY publications
    ADD CONSTRAINT publications_pkey PRIMARY KEY (publicationid);


--
-- Name: questioncomments_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY questioncomments
    ADD CONSTRAINT questioncomments_pkey PRIMARY KEY (commentid);


--
-- Name: questions_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (publicationid);


--
-- Name: questiontags_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY questiontags
    ADD CONSTRAINT questiontags_pkey PRIMARY KEY (questionid, tagid);


--
-- Name: tags_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (tagid);


--
-- Name: userbadges_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY userbadges
    ADD CONSTRAINT userbadges_pkey PRIMARY KEY (userid, badgeid);


--
-- Name: userroles_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY userroles
    ADD CONSTRAINT userroles_pkey PRIMARY KEY (roleid);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (userid);


--
-- Name: votes_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY votes
    ADD CONSTRAINT votes_pkey PRIMARY KEY (voteid);


--
-- Name: warnings_pkey; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY warnings
    ADD CONSTRAINT warnings_pkey PRIMARY KEY (warningid);


--
-- Name: ixfk_answers_questions; Type: INDEX; Schema: public; Owner: luiscosta
--

CREATE INDEX ixfk_answers_questions ON answers USING btree (questionid);


--
-- Name: ixfk_modregister_author_user; Type: INDEX; Schema: public; Owner: luiscosta
--

CREATE INDEX ixfk_modregister_author_user ON modregisters USING btree (userid_author);


--
-- Name: ixfk_modregister_target_user; Type: INDEX; Schema: public; Owner: luiscosta
--

CREATE INDEX ixfk_modregister_target_user ON modregisters USING btree (userid_target);


--
-- Name: ixfk_publications_users; Type: INDEX; Schema: public; Owner: luiscosta
--

CREATE INDEX ixfk_publications_users ON publications USING btree (userid);


--
-- Name: ixfk_questions_tags_tags; Type: INDEX; Schema: public; Owner: luiscosta
--

CREATE INDEX ixfk_questions_tags_tags ON questiontags USING btree (tagid);


--
-- Name: ixfk_user_badges; Type: INDEX; Schema: public; Owner: luiscosta
--

CREATE INDEX ixfk_user_badges ON userbadges USING btree (badgeid);


--
-- Name: ixfk_user_votes; Type: INDEX; Schema: public; Owner: luiscosta
--

CREATE INDEX ixfk_user_votes ON votes USING btree (userid);


--
-- Name: publications_search_idx; Type: INDEX; Schema: public; Owner: luiscosta
--

CREATE INDEX publications_search_idx ON publications USING gin (to_tsvector('english'::regconfig, body));


--
-- Name: questions_question_search_idx; Type: INDEX; Schema: public; Owner: luiscosta
--

CREATE INDEX questions_question_search_idx ON questions USING gin (to_tsvector('english'::regconfig, (title)::text));


--
-- Name: questions_updated_at; Type: INDEX; Schema: public; Owner: luiscosta
--

CREATE INDEX questions_updated_at ON publications USING btree (last_edit_date);


--
-- Name: tags_name_uindex; Type: INDEX; Schema: public; Owner: luiscosta
--

CREATE UNIQUE INDEX tags_name_uindex ON tags USING btree (name);


--
-- Name: users_email; Type: INDEX; Schema: public; Owner: luiscosta
--

CREATE INDEX users_email ON users USING hash (email);


--
-- Name: users_question_search_idx; Type: INDEX; Schema: public; Owner: luiscosta
--

CREATE INDEX users_question_search_idx ON users USING gin (to_tsvector('english'::regconfig, (username)::text));


--
-- Name: users_username; Type: INDEX; Schema: public; Owner: luiscosta
--

CREATE INDEX users_username ON users USING hash (username);


--
-- Name: answer_update_question_timestamp; Type: TRIGGER; Schema: public; Owner: luiscosta
--

CREATE TRIGGER answer_update_question_timestamp BEFORE INSERT OR UPDATE ON publications FOR EACH ROW EXECUTE PROCEDURE trigger_update_question_timestamp();


--
-- Name: auto_ban_on_warning_limit; Type: TRIGGER; Schema: public; Owner: luiscosta
--

CREATE TRIGGER auto_ban_on_warning_limit AFTER INSERT ON warnings FOR EACH ROW EXECUTE PROCEDURE trigger_auto_ban_on_warning_limit();


--
-- Name: auto_rank_up; Type: TRIGGER; Schema: public; Owner: luiscosta
--

CREATE TRIGGER auto_rank_up AFTER INSERT OR UPDATE ON votes FOR EACH ROW EXECUTE PROCEDURE user_badges_ranking();


--
-- Name: own_content_vote_trigger; Type: TRIGGER; Schema: public; Owner: luiscosta
--

CREATE TRIGGER own_content_vote_trigger AFTER INSERT OR UPDATE ON votes FOR EACH ROW EXECUTE PROCEDURE own_content_vote();


--
-- Name: Badge; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY userbadges
    ADD CONSTRAINT "Badge" FOREIGN KEY (badgeid) REFERENCES badges(badgeid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FK_Ban_ModRegister; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY bans
    ADD CONSTRAINT "FK_Ban_ModRegister" FOREIGN KEY (banid) REFERENCES modregisters(modregisterid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FK_Comment_Publication; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT "FK_Comment_Publication" FOREIGN KEY (publicationid) REFERENCES publications(publicationid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FK_Question_Category; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT "FK_Question_Category" FOREIGN KEY (categoryid) REFERENCES categories(categoryid) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: FK_Question_Publication; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT "FK_Question_Publication" FOREIGN KEY (publicationid) REFERENCES publications(publicationid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FK_User_Location; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY users
    ADD CONSTRAINT "FK_User_Location" FOREIGN KEY (locationid) REFERENCES locations(locationid) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: FK_Vote_Publication; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY votes
    ADD CONSTRAINT "FK_Vote_Publication" FOREIGN KEY (publicationid) REFERENCES publications(publicationid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FK_Vote_User; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY votes
    ADD CONSTRAINT "FK_Vote_User" FOREIGN KEY (userid) REFERENCES users(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FK_answercomments_answers; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY answercomments
    ADD CONSTRAINT "FK_answercomments_answers" FOREIGN KEY (answerid) REFERENCES answers(publicationid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FK_answercomments_comments; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY answercomments
    ADD CONSTRAINT "FK_answercomments_comments" FOREIGN KEY (commentid) REFERENCES comments(publicationid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FK_answers_publications; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT "FK_answers_publications" FOREIGN KEY (publicationid) REFERENCES publications(publicationid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FK_answers_questions; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY answers
    ADD CONSTRAINT "FK_answers_questions" FOREIGN KEY (questionid) REFERENCES questions(publicationid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FK_publications_users; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY publications
    ADD CONSTRAINT "FK_publications_users" FOREIGN KEY (userid) REFERENCES users(userid) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: FK_questioncomments_comments; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY questioncomments
    ADD CONSTRAINT "FK_questioncomments_comments" FOREIGN KEY (commentid) REFERENCES comments(publicationid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FK_questioncomments_questions; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY questioncomments
    ADD CONSTRAINT "FK_questioncomments_questions" FOREIGN KEY (questionid) REFERENCES questions(publicationid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: FK_warnings_modregisters; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY warnings
    ADD CONSTRAINT "FK_warnings_modregisters" FOREIGN KEY (warningid) REFERENCES modregisters(modregisterid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Question; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY questiontags
    ADD CONSTRAINT "Question" FOREIGN KEY (questionid) REFERENCES questions(publicationid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Tag; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY questiontags
    ADD CONSTRAINT "Tag" FOREIGN KEY (tagid) REFERENCES tags(tagid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: User; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY userbadges
    ADD CONSTRAINT "User" FOREIGN KEY (userid) REFERENCES users(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: author; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY modregisters
    ADD CONSTRAINT author FOREIGN KEY (userid_author) REFERENCES users(userid) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: target; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY modregisters
    ADD CONSTRAINT target FOREIGN KEY (userid_target) REFERENCES users(userid) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

