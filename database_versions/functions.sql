--------------------------FUNCTIONS----------------------------------------

---- Function that returns the tags of a question

CREATE OR REPLACE FUNCTION question_tags(pquestion_id int)
    RETURNS TABLE (tag character varying(10)) AS $func$
BEGIN
    return QUERY
    SELECT tags.name
    FROM tags INNER JOIN questiontags ON tags.tagid = questiontags.tagid
    WHERE questiontags.questionid = pquestion_id;
END
$func$  LANGUAGE plpgsql;


---- Function that returns the answers of a question and aditional / optional info

  CREATE OR REPLACE FUNCTION question_answers(pquestion_id int)
      RETURNS TABLE (
          id INTEGER,
          user_id INTEGER,
          username character varying(50),
          body TEXT,
          created_at timestamp
      ) AS $func$
  BEGIN
      RETURN QUERY
      SELECT answers.publicationid, users.userid, users.username, publications.body, publications.creation_date
      FROM answers INNER JOIN publications ON answers.publicationid = publications.publicationid
          RIGHT JOIN users ON publications.userid = users.userid
      WHERE answers.questionid = pquestion_id;
  END
  $func$  LANGUAGE plpgsql;


---- Function that returns the questions of a user

CREATE OR REPLACE FUNCTION user_questions(puser_id int)
    RETURNS TABLE (
        publicationid INTEGER,
        title character varying(100),
        body TEXT,
        solved_date TIMESTAMP,
        creation_date timestamp,
        last_edit_date timestamp,
        count_answers BIGINT

    ) AS $func$
BEGIN
    RETURN QUERY
    SELECT questions.publicationid, questions.title, publications.body, questions.solved_date, publications.creation_date,
        publications.last_edit_date, (SELECT COUNT(*) FROM answers WHERE questionid = questions.publicationid)
    FROM questions INNER JOIN publications ON questions.publicationid = publications.publicationid
    WHERE publications.userid = puser_id;
END
$func$  LANGUAGE plpgsql;


---- Function that counts the votes one user received

CREATE OR REPLACE FUNCTION count_vote_rating_received_user(puser_id int)
    RETURNS INTEGER AS $func$
DECLARE publicationvotecount INTEGER;
BEGIN
    SELECT COUNT(*) FROM votes INNER JOIN publications ON votes.publicationid = publications.publicationid
        RIGHT JOIN users ON publications.userid = users.userid WHERE users.userid = puser_id
    INTO publicationvotecount;

    IF publicationvotecount is null THEN
        publicationvotecount := 0;
    END IF;

    return publicationvotecount;
END
$func$  LANGUAGE plpgsql;


---- Function that returns important info about one user puser_id

CREATE OR REPLACE FUNCTION user_profile(puser_id int)
    RETURNS TABLE (
        username character varying(50),
        email character varying(100),
        type character varying(10),
        badge character varying(50),
        created_at date,
        count_votes_rating_received INT,
        count_questions BIGINT,
        count_answers BIGINT,
        count_votes_made BIGINT
    ) AS $func$
BEGIN
    RETURN QUERY
    SELECT users.username, users.email,
        (SELECT rolename FROM users INNER JOIN userroles ON users.roleid = userroles.roleid WHERE userid = puser_id),
        users.signup_date,
        count_vote_rating_received_user(puser_id),
        (SELECT COUNT(*) FROM publications INNER JOIN questions ON questions.publicationid = publications.publicationid
            RIGHT JOIN users ON publications.userid = users.userid WHERE users.userid = puser_id),
        (SELECT COUNT(*) FROM publications INNER JOIN answers ON answers.publicationid = publications.publicationid
            RIGHT JOIN users ON publications.userid = users.userid WHERE users.userid = puser_id),
        (SELECT COUNT(*) FROM votes WHERE votes.userid = puser_id)
    FROM users
    WHERE users.userid = puser_id;
END
$func$  LANGUAGE plpgsql;


---- Function that creates a new register on User Badges table associating the User total points to the badge he deserves

CREATE OR REPLACE FUNCTION user_badges_ranking()
    RETURNS TRIGGER as $func$
DECLARE target_user INTEGER;
BEGIN
    SELECT publications.userid FROM publications INNER JOIN votes ON publications.publicationid = votes.publicationid
    WHERE publications.publicationid = NEW.publicationid INTO target_user;
    IF count_vote_rating_received_user(target_user) = 1 THEN
        INSERT INTO userbadges(userid, badgeid) VALUES (target_user, 1);
    END IF;
    IF count_vote_rating_received_user(target_user) = 3 THEN
        INSERT INTO userbadges(userid, badgeid) VALUES (target_user, 2);
    END IF;
    IF count_vote_rating_received_user(target_user) = 15 THEN
        INSERT INTO userbadges(userid, badgeid) VALUES (target_user, 3);
    END IF;
    IF count_vote_rating_received_user(target_user) = 30 THEN
        INSERT INTO userbadges(userid, badgeid) VALUES (target_user, 4);
    END IF;
    IF count_vote_rating_received_user(target_user) = 50 THEN
        INSERT INTO userbadges(userid, badgeid) VALUES (target_user, 5);
    END IF;
    RETURN NULL;
END
$func$ LANGUAGE plpgsql;

---- Trigger that updates ranking

CREATE TRIGGER auto_rank_up AFTER INSERT OR UPDATE ON votes
FOR EACH ROW EXECUTE PROCEDURE user_badges_ranking();


---- Function that checks if the user is voting in his own content

CREATE OR REPLACE FUNCTION own_content_vote()
    RETURNS TRIGGER as $func$
DECLARE target_user INTEGER;
BEGIN
    SELECT publications.userid FROM publications INNER JOIN votes ON publications.publicationid = votes.publicationid
    WHERE publications.publicationid = NEW.publicationid INTO target_user;
    IF target_user = NEW.userid THEN
        RAISE EXCEPTION 'You cant vote on your own publications';
    END IF;
    RETURN NULL;
END
$func$  LANGUAGE plpgsql;

CREATE TRIGGER own_content_vote_trigger AFTER INSERT OR UPDATE ON votes
FOR EACH ROW EXECUTE PROCEDURE own_content_vote();



--------------------------------------------------------------------

---- This function adds a user to the ban table when he exceeds the warning limit (3)

DROP TRIGGER IF EXISTS auto_ban_on_warning_limit ON public.warnings;


CREATE OR REPLACE FUNCTION trigger_auto_ban_on_warning_limit()
    RETURNS "trigger" AS $func$
BEGIN
    IF (SELECT COUNT(*)
        FROM modregisters INNER JOIN users ON modregisters.userid_author = users.userid
            INNER JOIN warnings ON modregisters.modregisterid = warnings.warningid
        GROUP BY userid_target) = 3 THEN
        INSERT INTO bans(banid) VALUES(NEW.warningid);
    END IF;
    RETURN NULL;
END;
$func$  LANGUAGE plpgsql;

CREATE TRIGGER auto_ban_on_warning_limit AFTER INSERT ON warnings
FOR EACH ROW EXECUTE PROCEDURE trigger_auto_ban_on_warning_limit();

--- This function updates the column last_edit_date with the current timestamp everytime there is an update on the table

DROP TRIGGER IF EXISTS answer_update_question_timestamp ON public.publications;

CREATE OR REPLACE FUNCTION trigger_update_question_timestamp()
    RETURNS TRIGGER AS $func$
BEGIN
    new.last_edit_date := now();
    RETURN NEW;
END;
$func$  LANGUAGE plpgsql;

CREATE TRIGGER answer_update_question_timestamp BEFORE INSERT OR UPDATE ON publications
FOR EACH ROW EXECUTE PROCEDURE trigger_update_question_timestamp();


---- This function returns the username of the user of a given question

CREATE OR REPLACE FUNCTION getusernamefromquestion(questionid integer)
    RETURNS VARCHAR AS $$
BEGIN
    SELECT users.username
    FROM publications
        INNER JOIN questions on publications.publicationid = questions.publicationid
        INNER JOIN users on publications.userid = users.userid
    where questions.publicationid = $1;
END;

$$ LANGUAGE plpgsql;

---- This is the Full text search function

CREATE OR REPLACE FUNCTION search_questions(psearch text)
    RETURNS TABLE (questionid INTEGER) AS $func$
BEGIN
    return QUERY
    SELECT DISTINCT publications.publicationid
    FROM questions, publications
    WHERE to_tsvector(coalesce(questions.title,'') || ' ' || coalesce(publications.body,'')) @@ to_tsquery(psearch)
          OR questions.publicationid IN (
        SELECT DISTINCT(answers.questionid) FROM answers INNER JOIN publications ON answers.publicationid = publications.publicationid
        WHERE to_tsvector(coalesce(publications.body)) @@ to_tsquery(psearch)
    )
    ;
END
$func$  LANGUAGE plpgsql;

--- This function adds does two inserts : - INSERT INTO Questions and Publications

create or replace function insert_into_questions(body text, userid integer, title varchar, categoryid integer)
    returns void language plpgsql as $$
DECLARE result INTEGER;
begin
    insert into publications(body, userid)
    VALUES (body, userid)
    returning publications.publicationid AS publicationid INTO result;

    insert into questions(publicationid ,title, categoryid) VALUES (result, title, categoryid);
end $$;

--- Get tags from a given question id

CREATE OR REPLACE FUNCTION question_tags(pquestion_id int)
    RETURNS TABLE (tag character varying(10)) AS $func$
BEGIN
    return QUERY
    SELECT tags.name
    FROM tags INNER JOIN questiontags ON tags.tagid = questiontags.tagid
    WHERE questiontags.questionid = pquestion_id;
END
$func$  LANGUAGE plpgsql;

---- This function returns a table with all the data needed to print a list of TOP SCORED QUESTIONS

create or replace function top_scored_questions(skip integer, limitnumber integer)
    returns
        TABLE
        (
            publicationid integer,
            title character varying,
            body text,
            creation_date timestamp without time zone,
            solved_date timestamp without time zone,
            username character varying,
            userid integer,
            answers_count bigint,
            upvotes bigint,
            votes_count BIGINT,
            views_counter BIGINT)
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

---- This function returns a table with all the data needed to print a one question


CREATE OR REPLACE FUNCTION question_details_from_id (pubid INTEGER)
    RETURNS TABLE (
        publicationid INTEGER,
        title VARCHAR(100),
        body TEXT,
        creation_date TIMESTAMP,
        solved_date TIMESTAMP,
        username VARCHAR(10),
        userid INTEGER,
        answers_count BIGINT,
        upvotes BIGINT,
        down_votes BIGINT,
        views_counter BIGINT,
        category VARCHAR(100))
AS $func$
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
$func$  LANGUAGE plpgsql;


---- This function returns a table with all the data needed to print a list of RECENT QUESTIONS


CREATE OR REPLACE FUNCTION recent_questions(skip INTEGER, limitNumber INTEGER)
    RETURNS TABLE (
        publicationid INTEGER,
        title VARCHAR(100),
        body TEXT,
        creation_date TIMESTAMP,
        solved_date TIMESTAMP,
        username VARCHAR(10),
        userid INTEGER,
        answers_count BIGINT,
        upvotes BIGINT,
        votes_count BIGINT,
        views_counter BIGINT)
AS $func$
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
$func$  LANGUAGE plpgsql;

---- This function returns a table with all the data needed to print a list of UNANSWERED QUESTIONS


create or replace function unanswered_questions(skip integer, limitnumber integer)
    returns TABLE
    (
        publicationid integer,
        title character varying,
        body text,
        creation_date timestamp without time zone,
        solved_date timestamp without time zone,
        username character varying,
        userid integer,
        answers_count bigint,
        upvotes bigint,
        votes_count BIGINT,
        views_counter BIGINT)
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

create or replace function insert_into_answers(userid INTEGER, questionid INTEGER, body text)
    returns void language plpgsql as $$
DECLARE result INTEGER;
begin
    insert into publications(body, userid)
    VALUES (body, userid)
    returning publications.publicationid AS publicationid INTO result;

    insert into answers(publicationid , questionid) VALUES (result, questionid);
end $$;

CREATE OR REPLACE FUNCTION answers_from_questionid(qid INTEGER)
    RETURNS TABLE (
        answerid INTEGER,
        body TEXT,
        solved_date TIMESTAMP,
        creation_date TIMESTAMP,
        userid INTEGER,
        username VARCHAR(50)

    )
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