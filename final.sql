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

CREATE FUNCTION answers_from_questionid(qid integer)
RETURNS TABLE
(answerid integer, body text, solved_date timestamp without time zone, creation_date timestamp without time zone, userid integer, username character varying)
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

CREATE FUNCTION top_scored_users() RETURNS TABLE(userid integer, username character varying, avatar character varying, count_votes_rating_received integer, count_questions integer, count_answers integer, count_comments integer)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    SELECT users.userid, users.username, users.avatar,
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
        WHERE (SELECT COUNT(*) FROM question_answers(questions.publicationid)) = 0
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
-- Name: update_user_profile(integer, character varying, character varying, character varying, text, character varying); Type: FUNCTION; Schema: public; Owner: luiscosta
--

CREATE FUNCTION update_user_profile(uid integer, full_name character varying, e_mail character varying, location character varying, about_user text, image character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$
begin
    UPDATE users
    SET fullname = full_name, email = e_mail, about = about_user, locationid = (SELECT locationid FROM locations WHERE locations.name = location), avatar = image
    WHERE userid = uid;
end $$;


ALTER FUNCTION public.update_user_profile(uid integer, full_name character varying, e_mail character varying, location character varying, about_user text, image character varying) OWNER TO luiscosta;

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
    avatar character varying(256),
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
97	62
98	66
99	68
103	62
104	66
114	112
\.


--
-- Name: answercomments_commentid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('answercomments_commentid_seq', 1, false);


--
-- Data for Name: answers; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY answers (publicationid, questionid, solved_date) FROM stdin;
112	111	\N
116	115	\N
120	119	\N
52	17	\N
55	23	\N
60	31	\N
62	20	\N
66	33	\N
68	39	\N
70	23	\N
\.


--
-- Name: answers_publicationid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('answers_publicationid_seq', 1, false);


--
-- Data for Name: badges; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY badges (badgeid, name, description) FROM stdin;
1	Rookie	A frog
2	Amateur	Star arising
3	Pro	His journey should procceed
4	Expert	Loyal and brave
5	Master	The empowered one
6	Jedi	Some kind of god
\.


--
-- Name: badges_badgeid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('badges_badgeid_seq', 6, true);


--
-- Data for Name: bans; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY bans (banid, end_date) FROM stdin;
2	2018-03-29
4	2018-04-04
5	2017-05-31
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
8	Outdoors
9	Electronics
10	Music
11	Kids
12	Home
13	Computers
14	Garden
15	Clothing
18	Tools
25	Toys
30	Automotive
\.


--
-- Name: categories_categoryid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('categories_categoryid_seq', 36, true);


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY comments (publicationid) FROM stdin;
81
82
83
84
85
86
87
88
89
90
91
92
93
94
95
96
97
98
99
100
101
102
103
104
105
106
107
108
109
110
113
114
121
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
\.


--
-- Name: locations_locationid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('locations_locationid_seq', 104, true);


--
-- Data for Name: modregisters; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY modregisters (modregisterid, date_creation, reason, userid_author, userid_target) FROM stdin;
1	2017-05-29 15:01:58.664289	Offensive Speech	3	4
2	2017-05-29 15:01:58.686629	Wrong question structure	3	4
3	2017-05-29 15:01:58.697846	Bad username	3	4
4	2017-05-29 15:01:58.708932	Third Warning	4	4
5	2017-05-29 16:16:47.790483	dasjdksa,jd	107	3
\.


--
-- Name: modregisters_modregisterid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('modregisters_modregisterid_seq', 5, true);


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
1	When is the next full moon?	2017-05-29 15:01:58.764471	3	\N
2	What is the cheapest way to go to London?	2017-05-29 15:01:58.809009	3	\N
3	Do I get pregnant from sitting in public toilets?	2017-05-29 15:01:58.853509	3	\N
4	Whos the best football player in the world?	2017-05-29 15:01:58.87573	3	\N
5	The next full moon will be on 22nd June 2017	2017-05-29 15:01:58.886782	4	\N
6	You should explore Ryanair/EasyJet flight promotions	2017-05-29 15:01:58.897987	4	\N
7	Please tell me youre not serious, mate	2017-05-29 15:01:58.909078	4	\N
8	That question has no rational answer. Both players are great! Enjoy them while you can!	2017-05-29 15:01:58.920108	4	\N
9	Cristiano Ronaldo only thinks about himself	2017-05-29 15:01:58.931296	5	\N
10	Cristiano Ronaldo carries his National Team	2017-05-29 15:01:58.953518	6	\N
11	libero non mattis pulvinar nulla pede ullamcorper augue a suscipit nulla elit ac nulla	2017-05-29 15:01:58.975741	96	\N
12	nisi venenatis tristique fusce congue diam id ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam	2017-05-29 15:01:58.987145	52	\N
14	nulla eget eros elementum pellentesque quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc	2017-05-29 15:01:59.042656	97	\N
15	blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et ultrices	2017-05-29 15:01:59.064936	8	\N
16	ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non	2017-05-29 15:01:59.120659	99	\N
17	vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula	2017-05-29 15:01:59.165324	92	\N
18	posuere cubilia curae duis faucibus accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi	2017-05-29 15:01:59.209676	61	\N
19	duis mattis egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero convallis eget eleifend luctus	2017-05-29 15:01:59.243062	95	\N
20	blandit non interdum in ante vestibulum ante ipsum primis in faucibus orci luctus et	2017-05-29 15:01:59.287538	24	\N
22	suspendisse ornare consequat lectus in est risus auctor sed tristique in tempus sit amet sem fusce	2017-05-29 15:01:59.309711	48	\N
23	tempus sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi	2017-05-29 15:01:59.320796	65	\N
24	odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec	2017-05-29 15:01:59.343017	67	\N
25	tempor convallis nulla neque libero convallis eget eleifend luctus ultricies	2017-05-29 15:01:59.376575	86	\N
26	aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend	2017-05-29 15:01:59.409936	65	\N
27	scelerisque mauris sit amet eros suspendisse accumsan tortor quis turpis sed ante vivamus tortor duis mattis egestas metus aenean	2017-05-29 15:01:59.432158	85	\N
28	rutrum neque aenean auctor gravida sem praesent id massa id nisl venenatis lacinia	2017-05-29 15:01:59.465884	71	\N
29	egestas metus aenean fermentum donec ut mauris eget massa tempor convallis nulla neque libero	2017-05-29 15:01:59.488317	3	\N
30	adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam	2017-05-29 15:01:59.510483	19	\N
31	magna ac consequat metus sapien ut nunc vestibulum ante ipsum	2017-05-29 15:01:59.521632	72	\N
32	ac nulla sed vel enim sit amet nunc viverra dapibus nulla suscipit ligula in lacus curabitur at ipsum ac	2017-05-29 15:01:59.544104	18	\N
33	sit amet consectetuer adipiscing elit proin risus praesent lectus vestibulum	2017-05-29 15:01:59.566283	26	\N
34	ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae mauris viverra diam	2017-05-29 15:01:59.577393	56	\N
35	potenti nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam non mauris morbi non lectus aliquam sit	2017-05-29 15:01:59.599683	23	\N
36	lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a ipsum	2017-05-29 15:01:59.622085	64	\N
37	primis in faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus	2017-05-29 15:01:59.644334	61	\N
38	ac tellus semper interdum mauris ullamcorper purus sit amet nulla quisque	2017-05-29 15:01:59.709643	82	\N
39	quisque porta volutpat erat quisque erat eros viverra eget congue eget semper rutrum nulla nunc purus	2017-05-29 15:01:59.765534	58	\N
40	arcu libero rutrum ac lobortis vel dapibus at diam nam tristique tortor eu	2017-05-29 15:01:59.798878	19	\N
41	nec dui luctus rutrum nulla tellus in sagittis dui vel nisl	2017-05-29 15:01:59.843331	91	\N
42	lobortis est phasellus sit amet erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla ac	2017-05-29 15:01:59.854499	100	\N
43	nulla integer pede justo lacinia eget tincidunt eget tempus vel pede morbi	2017-05-29 15:01:59.876646	64	\N
44	platea dictumst morbi vestibulum velit id pretium iaculis diam erat fermentum justo nec condimentum neque sapien placerat ante nulla justo	2017-05-29 15:01:59.921139	59	\N
45	orci mauris lacinia sapien quis libero nullam sit amet turpis elementum ligula vehicula consequat morbi a	2017-05-29 15:01:59.932338	70	\N
46	amet justo morbi ut odio cras mi pede malesuada in imperdiet et	2017-05-29 15:01:59.943635	39	\N
47	elementum nullam varius nulla facilisi cras non velit nec nisi vulputate	2017-05-29 15:01:59.987956	82	\N
48	vestibulum proin eu mi nulla ac enim in tempor turpis nec euismod scelerisque	2017-05-29 15:02:00.010318	10	\N
49	sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula	2017-05-29 15:02:00.049116	93	\N
50	urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non velit nec	2017-05-29 15:02:00.077264	68	\N
51	porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh in lectus pellentesque	2017-05-29 15:02:00.110796	86	\N
52	felis donec semper sapien a libero nam dui proin leo odio	2017-05-29 15:02:00.146078	69	\N
53	orci luctus et ultrices posuere cubilia curae duis faucibus accumsan	2017-05-29 15:02:00.166473	37	\N
54	ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices	2017-05-29 15:02:00.18883	53	\N
55	luctus rutrum nulla tellus in sagittis dui vel nisl duis ac nibh fusce lacus purus aliquet at feugiat	2017-05-29 15:02:00.199987	93	\N
56	sagittis nam congue risus semper porta volutpat quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam	2017-05-29 15:02:00.211151	25	\N
57	faucibus cursus urna ut tellus nulla ut erat id mauris vulputate elementum nullam varius nulla facilisi cras non	2017-05-29 15:02:00.222128	36	\N
58	vestibulum quam sapien varius ut blandit non interdum in ante vestibulum	2017-05-29 15:02:00.23324	83	\N
59	in magna bibendum imperdiet nullam orci pede venenatis non sodales sed tincidunt eu felis	2017-05-29 15:02:00.244345	55	\N
60	amet nulla quisque arcu libero rutrum ac lobortis vel dapibus at diam nam tristique	2017-05-29 15:02:00.255456	19	\N
61	mattis odio donec vitae nisi nam ultrices libero non mattis pulvinar nulla pede ullamcorper	2017-05-29 15:02:00.26656	88	\N
62	ultrices phasellus id sapien in sapien iaculis congue vivamus metus arcu adipiscing molestie hendrerit at	2017-05-29 15:02:00.277659	58	\N
63	nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa	2017-05-29 15:02:00.288861	84	\N
64	in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa id	2017-05-29 15:02:00.300013	59	\N
65	vestibulum sit amet cursus id turpis integer aliquet massa id lobortis	2017-05-29 15:02:00.311154	90	\N
66	curae nulla dapibus dolor vel est donec odio justo sollicitudin ut suscipit a feugiat	2017-05-29 15:02:00.322345	60	\N
67	convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam	2017-05-29 15:02:00.333369	17	\N
68	quis orci eget orci vehicula condimentum curabitur in libero ut	2017-05-29 15:02:00.344456	30	\N
69	at lorem integer tincidunt ante vel ipsum praesent blandit lacinia erat	2017-05-29 15:02:00.355582	81	\N
70	proin risus praesent lectus vestibulum quam sapien varius ut blandit non interdum in	2017-05-29 15:02:00.366624	97	\N
71	quisque ut erat curabitur gravida nisi at nibh in hac habitasse platea dictumst	2017-05-29 15:02:00.377737	31	\N
72	eu interdum eu tincidunt in leo maecenas pulvinar lobortis est phasellus	2017-05-29 15:02:00.389021	4	\N
73	gravida sem praesent id massa id nisl venenatis lacinia aenean	2017-05-29 15:02:00.400082	64	\N
74	vivamus vestibulum sagittis sapien cum sociis natoque penatibus et magnis dis	2017-05-29 15:02:00.411288	80	\N
75	lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis a pede posuere	2017-05-29 15:02:00.422374	67	\N
76	erat nulla tempus vivamus in felis eu sapien cursus vestibulum proin eu mi nulla	2017-05-29 15:02:00.433387	89	\N
77	curae donec pharetra magna vestibulum aliquet ultrices erat tortor sollicitudin mi sit amet lobortis sapien sapien non mi integer	2017-05-29 15:02:00.444619	87	\N
78	in felis donec semper sapien a libero nam dui proin leo odio porttitor id consequat in consequat ut nulla sed	2017-05-29 15:02:00.455674	24	\N
79	a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate ut ultrices vel	2017-05-29 15:02:00.466735	78	\N
80	euismod scelerisque quam turpis adipiscing lorem vitae mattis nibh ligula nec sem duis aliquam convallis nunc proin at turpis	2017-05-29 15:02:00.477896	19	\N
81	eu massa donec dapibus duis at velit eu est congue elementum in	2017-05-29 15:02:00.488965	28	\N
82	nisl nunc rhoncus dui vel sem sed sagittis nam congue risus semper porta volutpat quam pede lobortis ligula	2017-05-29 15:02:00.500164	2	\N
83	pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut tellus nulla	2017-05-29 15:02:00.511334	41	\N
84	nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi	2017-05-29 15:02:00.522382	88	\N
85	ornare imperdiet sapien urna pretium nisl ut volutpat sapien arcu sed augue aliquam erat	2017-05-29 15:02:00.533586	97	\N
86	est quam pharetra magna ac consequat metus sapien ut nunc vestibulum ante ipsum	2017-05-29 15:02:00.544711	30	\N
87	aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel	2017-05-29 15:02:00.555778	16	\N
88	accumsan odio curabitur convallis duis consequat dui nec nisi volutpat eleifend donec ut dolor morbi vel lectus in quam fringilla	2017-05-29 15:02:00.566912	50	\N
89	duis aliquam convallis nunc proin at turpis a pede posuere nonummy integer non velit donec diam neque vestibulum eget vulputate	2017-05-29 15:02:00.577981	9	\N
90	cursus vestibulum proin eu mi nulla ac enim in tempor turpis	2017-05-29 15:02:00.589093	53	\N
91	et magnis dis parturient montes nascetur ridiculus mus etiam vel augue	2017-05-29 15:02:00.600226	51	\N
92	eu tincidunt in leo maecenas pulvinar lobortis est phasellus sit amet erat	2017-05-29 15:02:00.611376	47	\N
93	quis tortor id nulla ultrices aliquet maecenas leo odio condimentum id luctus nec molestie sed justo pellentesque viverra pede	2017-05-29 15:02:00.622683	50	\N
94	aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer	2017-05-29 15:02:00.63363	8	\N
95	et ultrices posuere cubilia curae mauris viverra diam vitae quam suspendisse	2017-05-29 15:02:00.644705	88	\N
96	magna ac consequat metus sapien ut nunc vestibulum ante ipsum primis in faucibus	2017-05-29 15:02:00.655932	52	\N
97	pellentesque volutpat dui maecenas tristique est et tempus semper est	2017-05-29 15:02:00.666964	77	\N
98	in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer eget rutrum at lorem integer tincidunt ante vel ipsum	2017-05-29 15:02:00.678051	20	\N
99	in lectus pellentesque at nulla suspendisse potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus	2017-05-29 15:02:00.689225	3	\N
100	purus aliquet at feugiat non pretium quis lectus suspendisse potenti in eleifend quam a odio in hac habitasse platea dictumst	2017-05-29 15:02:00.700259	30	\N
101	vulputate ut ultrices vel augue vestibulum ante ipsum primis in	2017-05-29 15:02:00.711496	76	\N
102	sodales sed tincidunt eu felis fusce posuere felis sed lacus	2017-05-29 15:02:00.722661	77	\N
103	rutrum nulla nunc purus phasellus in felis donec semper sapien a libero nam dui proin leo odio	2017-05-29 15:02:00.733715	80	\N
104	quam pede lobortis ligula sit amet eleifend pede libero quis orci nullam molestie nibh	2017-05-29 15:02:00.744906	82	\N
105	natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis natoque	2017-05-29 15:02:00.756082	9	\N
106	interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa donec dapibus duis at	2017-05-29 15:02:00.76704	35	\N
107	nullam porttitor lacus at turpis donec posuere metus vitae ipsum aliquam	2017-05-29 15:02:00.77819	94	\N
108	in imperdiet et commodo vulputate justo in blandit ultrices enim lorem ipsum dolor sit amet	2017-05-29 15:02:00.789308	21	\N
109	ultrices enim lorem ipsum dolor sit amet consectetuer adipiscing elit proin interdum mauris non ligula pellentesque	2017-05-29 15:02:00.800357	83	\N
110	augue vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia	2017-05-29 15:02:00.811594	1	\N
111	<p>This is a question test</p>\r\n	2017-05-29 15:21:18.168106	107	\N
112	<p>This is an answer test</p>\r\n	2017-05-29 15:22:20.397932	107	\N
114	This is an answer comment test	2017-05-29 16:13:08.216122	107	\N
113	This is a comment question testyyy	2017-05-29 15:22:29.732725	107	\N
116	<p>This is just a testccccc</p>\r\n	2017-05-29 21:24:56.428504	107	\N
115	<p>related questions to this(edited)</p>\r\n	2017-05-29 20:51:25.938942	107	\N
119	<p>this is just it</p>\r\n	2017-05-29 22:41:06.311388	107	\N
120	<p>sdsajkdaljsdksdsadsad</p>\r\n	2017-05-29 23:33:22.912601	107	\N
121	Just a goddamn test	2017-05-30 00:31:30.826687	107	\N
\.


--
-- Name: publications_publicationid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('publications_publicationid_seq', 121, true);


--
-- Data for Name: questioncomments; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY questioncomments (commentid, questionid) FROM stdin;
93	33
113	111
121	119
\.


--
-- Name: questioncomments_commentid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('questioncomments_commentid_seq', 1, false);


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY questions (publicationid, title, categoryid, solved_date, views_counter) FROM stdin;
17	pellentesque laoreet sociis	18	\N	0
20	feugiat orci nascetur penatibus	25	\N	0
23	nostra libero libero nunc ac	2	\N	0
32	scelerisque Vivamus ridiculus nec	12	\N	0
115	Automotive test category	25	\N	22
31	tempor cubilia	11	\N	2
33	ridiculus in Vivamus	14	\N	3
39	fames fames blandit	14	\N	8
119	this is it	30	\N	7
111	This is a question test	30	\N	46
\.


--
-- Name: questions_publicationid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('questions_publicationid_seq', 1, false);


--
-- Data for Name: questiontags; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY questiontags (questionid, tagid) FROM stdin;
111	107
111	108
111	109
115	110
119	107
119	108
119	111
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
6	football
7	matrices
8	Monitored
9	Cross-group
10	system-worthy
11	empowering
12	Intuitive
13	benchmark
14	Diverse
15	actuating
16	info-mediaries
17	systemic
18	Decentralized
19	Persevering
20	Graphic Interface
21	internet solution
24	content-based
25	global
27	Persistent
28	full-range
29	Sharable
30	Organic
31	interface
32	24 hour
33	discrete
34	Down-sized
35	Stand-alone
36	capacity
37	Customer-focused
38	5th generation
39	groupware
40	demand-driven
41	neutral
42	reciprocal
43	time-frame
44	instruction set
45	encoding
46	knowledge user
47	Quality-focused
48	Profit-focused
50	Extended
51	Distributed
52	intermediate
53	heuristic
54	Advanced
56	data-warehouse
57	Assimilated
58	migration
59	disintermediate
60	circuit
61	artificial intelligence
62	Progressive
63	eco-centric
65	incremental
66	composite
67	policy
68	archive
69	interactive
70	Open-source
71	middleware
72	Integrated
73	Automated
75	Balanced
76	context-sensitive
77	conglomeration
78	scalable
79	contextually-based
80	knowledge base
81	initiative
82	multi-state
83	Fundamental
85	hybrid
86	zero defect
87	product
88	paradigm
89	leverage
92	maximized
94	stable
96	support
97	local area network
99	responsive
100	project
101	toolset
102	object-oriented
103	ability
106	Object-based
107	test
108	lbaw
109	feup
110	related
111	final
\.


--
-- Name: tags_tagid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('tags_tagid_seq', 111, true);


--
-- Data for Name: userbadges; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY userbadges (userid, badgeid) FROM stdin;
3	1
29	1
65	1
45	1
45	2
72	1
18	1
26	1
58	1
58	2
30	1
60	1
107	1
107	2
19	1
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

COPY users (userid, username, email, password, fullname, about, website, signup_date, last_login, locationid, roleid, avatar) FROM stdin;
1	editor	editor@editor.pt	12345678	\N	\N	\N	2017-05-29	\N	1	3	/images/person-flat.png
2	warneduser	warneduser@user.pt	12345678	\N	\N	\N	2017-05-29	\N	4	1	/images/person-flat.png
3	luistelmocosta	luistelmocosta@gmail.com	12345678	\N	\N	\N	2017-05-29	\N	4	2	/images/person-flat.png
4	admin	admin@admin.pt	12345678	\N	\N	\N	2017-05-29	\N	4	2	/images/person-flat.png
5	member	member@member.pt	12345678	\N	\N	\N	2017-05-29	\N	3	1	/images/person-flat.png
6	ronaldo7	ronaldo@ronaldo.pt	12345678	\N	\N	\N	2017-05-29	\N	3	1	/images/person-flat.png
7	cfuller0	cwatkins0@disqus.com	eCXLJXL	\N	\N	\N	2017-05-29	\N	73	1	/images/person-flat.png
8	pyoung1	awilliams1@sphinn.com	g58TSo5	\N	\N	\N	2017-05-29	\N	55	2	/images/person-flat.png
9	dcarter2	sgriffin2@apache.org	X0oACZPB	\N	\N	\N	2017-05-29	\N	43	1	/images/person-flat.png
10	mhenry3	sdunn3@forbes.com	NGvubdo	\N	\N	\N	2017-05-29	\N	32	1	/images/person-flat.png
11	wgraham4	hsullivan4@dailymail.co.uk	qffCv9	\N	\N	\N	2017-05-29	\N	85	3	/images/person-flat.png
12	cgeorge5	sarmstrong5@yale.edu	KMp8oGS	\N	\N	\N	2017-05-29	\N	15	1	/images/person-flat.png
13	clynch6	rdixon6@yahoo.com	MR2EmwzWHm2y	\N	\N	\N	2017-05-29	\N	27	2	/images/person-flat.png
14	malexander7	pkelley7@patch.com	mlTSYuE9udF	\N	\N	\N	2017-05-29	\N	30	1	/images/person-flat.png
15	estevens8	dyoung8@bing.com	cjKKfUhCq4	\N	\N	\N	2017-05-29	\N	40	1	/images/person-flat.png
16	kjackson9	pmcdonald9@marketwatch.com	M7pacvs51	\N	\N	\N	2017-05-29	\N	7	1	/images/person-flat.png
17	jandrewsa	pkima@multiply.com	4C5GlIQ	\N	\N	\N	2017-05-29	\N	55	2	/images/person-flat.png
18	mwilliamsb	rreidb@sfgate.com	bu1LzN3bjin1	\N	\N	\N	2017-05-29	\N	16	3	/images/person-flat.png
19	ckelleyc	flittlec@technorati.com	AokjOQmcrkM	\N	\N	\N	2017-05-29	\N	52	1	/images/person-flat.png
20	mdixond	rbryantd@howstuffworks.com	4647h49kNuID	\N	\N	\N	2017-05-29	\N	40	2	/images/person-flat.png
21	vnguyene	bgilberte@xing.com	vdTZ3R28J	\N	\N	\N	2017-05-29	\N	17	3	/images/person-flat.png
22	crayf	mthomasf@stumbleupon.com	8BMhXNVzwy	\N	\N	\N	2017-05-29	\N	22	2	/images/person-flat.png
23	amedinag	aalexanderg@disqus.com	wHc7Q8O	\N	\N	\N	2017-05-29	\N	55	3	/images/person-flat.png
24	bmurphyh	croseh@comcast.net	cyCti87i	\N	\N	\N	2017-05-29	\N	90	2	/images/person-flat.png
25	tjacobsi	rhansoni@psu.edu	988ieJXBJ0uC	\N	\N	\N	2017-05-29	\N	42	1	/images/person-flat.png
26	carmstrongj	jlittlej@shop-pro.jp	V3nxid	\N	\N	\N	2017-05-29	\N	28	3	/images/person-flat.png
27	dpiercek	mmorenok@hc360.com	eActzzFZ	\N	\N	\N	2017-05-29	\N	27	2	/images/person-flat.png
28	slittlel	efoxl@usatoday.com	727tKDTXU6	\N	\N	\N	2017-05-29	\N	25	3	/images/person-flat.png
29	cgardnerm	sortizm@163.com	I4DJvx65	\N	\N	\N	2017-05-29	\N	56	1	/images/person-flat.png
30	dmeyern	dwashingtonn@e-recht24.de	sStOKsUA	\N	\N	\N	2017-05-29	\N	81	3	/images/person-flat.png
31	dandrewso	jscotto@ifeng.com	o6WFahkf	\N	\N	\N	2017-05-29	\N	20	2	/images/person-flat.png
32	amarshallp	brichardsonp@altervista.org	BBWjvHZ	\N	\N	\N	2017-05-29	\N	11	1	/images/person-flat.png
33	hmccoyq	landersonq@dyndns.org	nC6quZt3Vu	\N	\N	\N	2017-05-29	\N	22	2	/images/person-flat.png
34	aroser	rburtonr@pen.io	8wX7HX2FWd	\N	\N	\N	2017-05-29	\N	62	3	/images/person-flat.png
35	mriveras	mnicholss@newyorker.com	kfkNCFzL	\N	\N	\N	2017-05-29	\N	58	3	/images/person-flat.png
36	sburket	dhartt@unc.edu	zbuB1z	\N	\N	\N	2017-05-29	\N	34	2	/images/person-flat.png
37	krobertsu	egarciau@businessweek.com	YwG7NNpSHXP0	\N	\N	\N	2017-05-29	\N	15	1	/images/person-flat.png
38	sdunnv	pkennedyv@blinklist.com	ghH1UBOwSII	\N	\N	\N	2017-05-29	\N	80	2	/images/person-flat.png
39	aruizw	pweaverw@myspace.com	UFW8qUxR0zvV	\N	\N	\N	2017-05-29	\N	38	3	/images/person-flat.png
40	rnguyenx	kwalkerx@bigcartel.com	7ZKZ4Se9kZ	\N	\N	\N	2017-05-29	\N	74	2	/images/person-flat.png
41	jcoopery	wbakery@tinyurl.com	yeAAjrJe	\N	\N	\N	2017-05-29	\N	38	2	/images/person-flat.png
42	dedwardsz	aclarkz@buzzfeed.com	HoUni2ObeA	\N	\N	\N	2017-05-29	\N	61	2	/images/person-flat.png
43	sfrazier10	lboyd10@webeden.co.uk	eWKI454L4E	\N	\N	\N	2017-05-29	\N	19	1	/images/person-flat.png
44	jhanson11	ecarroll11@slate.com	QiqQulDAKY	\N	\N	\N	2017-05-29	\N	35	1	/images/person-flat.png
45	amatthews12	fhanson12@google.de	nuiS8pp	\N	\N	\N	2017-05-29	\N	40	3	/images/person-flat.png
46	proberts13	jpayne13@de.vu	3HgIN4av	\N	\N	\N	2017-05-29	\N	15	1	/images/person-flat.png
47	ajames14	skelley14@printfriendly.com	ERpBVk4l	\N	\N	\N	2017-05-29	\N	71	1	/images/person-flat.png
48	llarson15	jpowell15@microsoft.com	8xSFxIiXkOU	\N	\N	\N	2017-05-29	\N	42	1	/images/person-flat.png
49	nfowler16	carmstrong16@youku.com	j1TkDtT5GChP	\N	\N	\N	2017-05-29	\N	65	3	/images/person-flat.png
50	wwright17	rrogers17@prlog.org	z7phI4jH	\N	\N	\N	2017-05-29	\N	35	1	/images/person-flat.png
51	jmcdonald18	along18@cbslocal.com	L7Hjmlm42	\N	\N	\N	2017-05-29	\N	31	3	/images/person-flat.png
52	esnyder19	akelley19@unicef.org	4KSqD9SB	\N	\N	\N	2017-05-29	\N	16	2	/images/person-flat.png
53	dyoung1a	bevans1a@cocolog-nifty.com	1b3HaMb	\N	\N	\N	2017-05-29	\N	17	3	/images/person-flat.png
54	cwallace1b	jperkins1b@imgur.com	8GaS8Ywe	\N	\N	\N	2017-05-29	\N	79	3	/images/person-flat.png
55	mfoster1c	raustin1c@virginia.edu	bikq2ItVaiO	\N	\N	\N	2017-05-29	\N	39	2	/images/person-flat.png
56	cparker1d	jedwards1d@simplemachines.org	jSmyorq3DA3	\N	\N	\N	2017-05-29	\N	61	2	/images/person-flat.png
57	jsmith1e	mbowman1e@homestead.com	SvWTCT2	\N	\N	\N	2017-05-29	\N	89	1	/images/person-flat.png
58	dclark1f	fphillips1f@mac.com	CrjZ6hg	\N	\N	\N	2017-05-29	\N	11	2	/images/person-flat.png
59	nfrazier1g	kallen1g@fotki.com	G8Qc6zdtb	\N	\N	\N	2017-05-29	\N	50	2	/images/person-flat.png
60	gbrown1h	bwalker1h@cnbc.com	NhqOqF	\N	\N	\N	2017-05-29	\N	52	3	/images/person-flat.png
61	sharrison1i	etaylor1i@nyu.edu	yJei58AOb	\N	\N	\N	2017-05-29	\N	81	3	/images/person-flat.png
62	jaustin1j	mlewis1j@rambler.ru	ZdmbRUY	\N	\N	\N	2017-05-29	\N	70	3	/images/person-flat.png
63	jrogers1k	clong1k@yellowbook.com	BdpM6hwDdKX	\N	\N	\N	2017-05-29	\N	40	2	/images/person-flat.png
64	jmartin1l	bwatson1l@smugmug.com	kluqiB9C	\N	\N	\N	2017-05-29	\N	30	1	/images/person-flat.png
65	jhall1m	pcastillo1m@godaddy.com	hj0ZJsygJ	\N	\N	\N	2017-05-29	\N	87	3	/images/person-flat.png
66	plee1n	mgibson1n@cornell.edu	5GmYA7SKA	\N	\N	\N	2017-05-29	\N	3	3	/images/person-flat.png
67	dporter1o	bfields1o@senate.gov	iZFTO4u2KCgk	\N	\N	\N	2017-05-29	\N	28	1	/images/person-flat.png
68	jkim1p	tdiaz1p@artisteer.com	SEO7kfj9	\N	\N	\N	2017-05-29	\N	83	2	/images/person-flat.png
69	ehernandez1q	dross1q@1und1.de	K1N4MGc3YqP	\N	\N	\N	2017-05-29	\N	53	2	/images/person-flat.png
70	gmiller1r	prichardson1r@surveymonkey.com	ju00Q2masJKf	\N	\N	\N	2017-05-29	\N	4	3	/images/person-flat.png
71	ewallace1s	eprice1s@prlog.org	KThqVf	\N	\N	\N	2017-05-29	\N	91	2	/images/person-flat.png
72	lkelley1t	ecole1t@goo.gl	QCivhCXGwM0	\N	\N	\N	2017-05-29	\N	83	3	/images/person-flat.png
73	cshaw1u	gwatkins1u@csmonitor.com	ZvvQYcDwZ4vx	\N	\N	\N	2017-05-29	\N	41	2	/images/person-flat.png
74	egreene1v	thunt1v@prlog.org	YvxJocvAWfe	\N	\N	\N	2017-05-29	\N	47	2	/images/person-flat.png
75	jtaylor1w	dlawson1w@marriott.com	KMKp2K3JgO	\N	\N	\N	2017-05-29	\N	70	3	/images/person-flat.png
76	bthomas1x	jfisher1x@google.co.jp	yamh22QaNhQ	\N	\N	\N	2017-05-29	\N	46	1	/images/person-flat.png
77	lallen1y	ccrawford1y@sciencedirect.com	0khnJh	\N	\N	\N	2017-05-29	\N	91	1	/images/person-flat.png
78	awarren1z	aanderson1z@arstechnica.com	TQnrVaN	\N	\N	\N	2017-05-29	\N	84	1	/images/person-flat.png
79	rwells20	agreen20@zdnet.com	2pjRjX	\N	\N	\N	2017-05-29	\N	25	3	/images/person-flat.png
80	blane21	pfuller21@who.int	pBgMvolRYV	\N	\N	\N	2017-05-29	\N	9	2	/images/person-flat.png
81	hturner22	ageorge22@slate.com	YGAwbziY2Bg	\N	\N	\N	2017-05-29	\N	10	3	/images/person-flat.png
82	fcox23	vmorales23@prweb.com	z9SgT0Q	\N	\N	\N	2017-05-29	\N	43	3	/images/person-flat.png
83	tclark24	rromero24@w3.org	Ur3ezNVZa	\N	\N	\N	2017-05-29	\N	1	1	/images/person-flat.png
84	rcox25	rsullivan25@howstuffworks.com	4NY8kbSO	\N	\N	\N	2017-05-29	\N	66	1	/images/person-flat.png
85	scarpenter26	jgilbert26@wordpress.org	Ri4qBabTeLB	\N	\N	\N	2017-05-29	\N	59	3	/images/person-flat.png
86	fwallace27	dray27@squidoo.com	MClUXQL51e	\N	\N	\N	2017-05-29	\N	61	3	/images/person-flat.png
87	knichols28	tphillips28@wp.com	Lvpp7AdPYJ	\N	\N	\N	2017-05-29	\N	83	2	/images/person-flat.png
88	sroberts29	slane29@chron.com	1L0VP0	\N	\N	\N	2017-05-29	\N	92	2	/images/person-flat.png
89	mfisher2a	etaylor2a@bizjournals.com	MGde02	\N	\N	\N	2017-05-29	\N	86	1	/images/person-flat.png
90	rpierce2b	ktaylor2b@aol.com	nzQVDKVsxpxi	\N	\N	\N	2017-05-29	\N	34	3	/images/person-flat.png
91	jdunn2c	pfreeman2c@spotify.com	mFGwvXHsNPg	\N	\N	\N	2017-05-29	\N	66	2	/images/person-flat.png
92	rduncan2d	dgriffin2d@shop-pro.jp	Oe1a8TM1E4t	\N	\N	\N	2017-05-29	\N	30	1	/images/person-flat.png
93	lgeorge2e	jroberts2e@tiny.cc	3jbC6qFuf	\N	\N	\N	2017-05-29	\N	40	2	/images/person-flat.png
94	ljones2f	bstanley2f@indiegogo.com	XGMgcn7gZ9j	\N	\N	\N	2017-05-29	\N	13	1	/images/person-flat.png
95	mlynch2g	wpalmer2g@globo.com	UKS1gx	\N	\N	\N	2017-05-29	\N	84	3	/images/person-flat.png
96	sjohnson2h	revans2h@discuz.net	rmy4ZkCO9b	\N	\N	\N	2017-05-29	\N	92	1	/images/person-flat.png
97	gmorris2i	sjackson2i@sfgate.com	iItAGleErkye	\N	\N	\N	2017-05-29	\N	9	3	/images/person-flat.png
98	rhoward2j	dcarr2j@utexas.edu	mISgaJ5R	\N	\N	\N	2017-05-29	\N	15	2	/images/person-flat.png
99	ralvarez2k	tjordan2k@bluehost.com	R6iqI5pEeZ	\N	\N	\N	2017-05-29	\N	26	3	/images/person-flat.png
100	crobinson2l	ngonzales2l@bigcartel.com	yMPDBniqW1	\N	\N	\N	2017-05-29	\N	81	3	/images/person-flat.png
101	rstone2m	sgriffin2m@vinaora.com	LNB4sGg	\N	\N	\N	2017-05-29	\N	36	3	/images/person-flat.png
102	kgreen2n	rcooper2n@reddit.com	UVeFJ95	\N	\N	\N	2017-05-29	\N	71	3	/images/person-flat.png
103	abutler2o	cgrant2o@howstuffworks.com	elKmKGK	\N	\N	\N	2017-05-29	\N	2	3	/images/person-flat.png
104	mharrison2p	khenry2p@studiopress.com	15d7kYZSxq56	\N	\N	\N	2017-05-29	\N	65	2	/images/person-flat.png
105	jwatson2q	dharrison2q@craigslist.org	QEOV6XOVqu	\N	\N	\N	2017-05-29	\N	61	3	/images/person-flat.png
106	aholmes2r	wlewis2r@mediafire.com	wLe1ZIe7s	\N	\N	\N	2017-05-29	\N	79	3	/images/person-flat.png
107	reverse	reverse@reverse.pt	$2y$10$vsixBDKMxudoRlfYRfqrz.YLISU.MZxDSGUULnwtcqV60uGoO3nyu	\N	\N	\N	2017-05-29	\N	\N	3	/images/person-flat.png
110	passwordtest	pass@pass.pt	$2y$10$K91CQIqEaHorv1Ww10i37.FKrWHcihJPeDG8Cnb/9GjcDwJDekntu	\N	\N	\N	2017-05-29	\N	\N	1	/images/person-flat.png
111	badpass	bad@bad.pt	$2y$10$ychrsvlUso5UYSD/LuoX4etfJHLVGgRdHtlazSVleYyUO3cYL3UcK	\N	\N	\N	2017-05-29	\N	\N	1	/images/person-flat.png
112	lamelol	lame@lame.pt	$2y$10$Ub7XW3skHbqcf0aAXaiWaeWnw6SbGlGt77aEc2RKgOFv6wfVccVIK	\N	\N	\N	2017-05-29	\N	\N	1	/images/person-flat.png
\.


--
-- Name: users_userid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('users_userid_seq', 112, true);


--
-- Data for Name: votes; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY votes (voteid, "values", publicationid, userid) FROM stdin;
1	1	1	1
2	0	1	2
3	-1	2	2
7	1	23	3
11	1	31	3
12	1	32	3
13	1	33	2
14	1	39	1
15	1	39	2
16	1	39	3
17	1	39	4
18	-1	39	5
19	-1	39	6
21	-1	23	7
22	-1	23	8
25	1	39	107
26	1	68	107
27	1	33	107
28	1	66	107
29	1	31	107
30	1	60	107
\.


--
-- Name: votes_voteid_seq; Type: SEQUENCE SET; Schema: public; Owner: luiscosta
--

SELECT pg_catalog.setval('votes_voteid_seq', 31, true);


--
-- Data for Name: warnings; Type: TABLE DATA; Schema: public; Owner: luiscosta
--

COPY warnings (warningid) FROM stdin;
2
3
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
-- Name: tags_name_key; Type: CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_name_key UNIQUE (name);


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
-- Name: users_email; Type: INDEX; Schema: public; Owner: luiscosta
--

CREATE INDEX users_email ON users USING hash (email);


--
-- Name: users_question_search_idx; Type: INDEX; Schema: public; Owner: luiscosta
--

CREATE INDEX users_question_search_idx ON users USING gin (to_tsvector('english'::regconfig, (username)::text));


--
-- Name: users_username_uindex; Type: INDEX; Schema: public; Owner: luiscosta
--

CREATE UNIQUE INDEX users_username_uindex ON users USING btree (username);


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
-- Name: FK_User_UserRole; Type: FK CONSTRAINT; Schema: public; Owner: luiscosta
--

ALTER TABLE ONLY users
    ADD CONSTRAINT "FK_User_UserRole" FOREIGN KEY (roleid) REFERENCES userroles(roleid) ON UPDATE CASCADE ON DELETE SET NULL;


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

