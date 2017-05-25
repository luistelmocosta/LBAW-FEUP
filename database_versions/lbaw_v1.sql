CREATE TABLE badges
(
    badgeid SERIAL PRIMARY KEY,
    name VARCHAR(50),
    description VARCHAR(100) NOT NULL,
    CONSTRAINT badge_description CHECK(CHAR_LENGTH(description) >= 2 AND CHAR_LENGTH(description) <= 100)
);


CREATE TABLE categories
(
    categoryid SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT valid_category CHECK(CHAR_LENGTH(name) >= 3 AND CHAR_LENGTH(name) <= 50)
);

CREATE TABLE userroles
(
    roleid SERIAL PRIMARY KEY,
    rolename VARCHAR(50) NOT NULL,
    CONSTRAINT user_role CHECK(rolename IN ('reg', 'mod', 'admin'))
);

CREATE TABLE locations
(
    locationid SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE users
(
    userid SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(70) NOT NULL,
    password VARCHAR(256) NOT NULL,
    fullname VARCHAR(200),
    about VARCHAR(500),
    website VARCHAR(150),
    signup_date DATE DEFAULT CURRENT_DATE NOT NULL,
    last_login TIMESTAMP,
    locationid INTEGER,
    roleid INTEGER DEFAULT 1,
    avatar VARCHAR(256),
    CONSTRAINT valid_date CHECK(last_login > signup_date),
    CONSTRAINT valid_password CHECK(CHAR_LENGTH(password) >= 6 AND CHAR_LENGTH(password) < 256),
    CONSTRAINT valid_username CHECK(CHAR_LENGTH(username) >= 1 AND CHAR_LENGTH(username) < 20),
    CONSTRAINT valid_fullname CHECK(CHAR_LENGTH(fullname) >= 6 AND CHAR_LENGTH(fullname) <= 50),
    CONSTRAINT valid_email CHECK(CHAR_LENGTH(email) >= 6 AND CHAR_LENGTH(email) <= 50),
    CONSTRAINT "FK_User_Location"
    FOREIGN KEY ("locationid") REFERENCES locations ("locationid") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "FK_User_UserRole"
    FOREIGN KEY ("roleid") REFERENCES userroles ("roleid") ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE INDEX users_question_search_idx ON users USING gin(to_tsvector('english', username));
CREATE INDEX users_email ON users USING hash(email);

CREATE TABLE modregisters
(
    modregisterid SERIAL PRIMARY KEY,
    date_creation TIMESTAMP DEFAULT now() NOT NULL,
    reason VARCHAR(200) NOT NULL,
    userid_author INTEGER NOT NULL,
    userid_target INTEGER NOT NULL,
    CONSTRAINT author
    FOREIGN KEY ("userid_author") REFERENCES users ("userid") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT target
    FOREIGN KEY ("userid_target") REFERENCES users ("userid") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX ixfk_modregister_target_user ON modregisters USING btree (userid_target);
CREATE INDEX ixfk_modregister_author_user ON modregisters USING btree (userid_author);

CREATE TABLE warnings
(
    warningid SERIAL PRIMARY KEY,
    CONSTRAINT "FK_warnings_modregisters"
    FOREIGN KEY ("warningid") REFERENCES modregisters ("modregisterid") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE bans
(
    banid SERIAL PRIMARY KEY,
    end_date DATE,
    CONSTRAINT "FK_Ban_ModRegister"
    FOREIGN KEY ("banid") REFERENCES modregisters ("modregisterid") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE publications
(
    publicationid SERIAL PRIMARY KEY,
    body text NOT NULL ,
    creation_date TIMESTAMP DEFAULT now() NOT NULL,
    userid INTEGER NOT NULL,
    last_edit_date TIMESTAMP,
    CONSTRAINT body_length CHECK (CHAR_LENGTH(body) >= 10 AND CHAR_LENGTH(body) <= 1000),
    CONSTRAINT "FK_publications_users"
    FOREIGN KEY ("userid") REFERENCES users ("userid") ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE INDEX publications_search_idx ON publications USING gin(to_tsvector('english', body));
CREATE INDEX questions_updated_at ON publications USING btree(last_edit_date);
CREATE INDEX ixfk_publications_users ON publications USING btree (userid);

CREATE TABLE questions
(
    publicationid SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    categoryid INTEGER NOT NULL,
    solved_date TIMESTAMP,
    views_counter BIGINT DEFAULT 0 NOT NULL,
    CONSTRAINT title_length CHECK (CHAR_LENGTH(title) >= 3 AND CHAR_LENGTH(title) <= 50),
    CONSTRAINT "FK_Question_Category"
    FOREIGN KEY ("categoryid") REFERENCES categories ("categoryid") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "FK_Question_Publication"
    FOREIGN KEY ("publicationid") REFERENCES publications ("publicationid") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX questions_question_search_idx ON questions USING gin(to_tsvector('english', title));

CREATE TABLE comments
(
    publicationid SERIAL PRIMARY KEY,
    CONSTRAINT "FK_Comment_Publication"
    FOREIGN KEY ("publicationid") REFERENCES publications ("publicationid") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE questioncomments
(
    commentid SERIAL PRIMARY KEY,
    questionid INTEGER NOT NULL,
    CONSTRAINT "FK_questioncomments_comments"
    FOREIGN KEY ("commentid") REFERENCES comments ("publicationid") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "FK_questioncomments_questions"
    FOREIGN KEY ("questionid") REFERENCES questions ("publicationid") ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE answers
(
    publicationid SERIAL PRIMARY KEY,
    questionid INTEGER NOT NULL,
    solved_date TIMESTAMP,
    CONSTRAINT "FK_answers_questions"
    FOREIGN KEY ("questionid") REFERENCES questions ("publicationid") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "FK_answers_publications"
    FOREIGN KEY ("publicationid") REFERENCES publications ("publicationid") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX ixfk_answers_questions ON answers USING btree (questionid);

CREATE TABLE answercomments
(
    commentid SERIAL PRIMARY KEY,
    answerid INTEGER NOT NULL,
    CONSTRAINT "FK_answercomments_comments"
    FOREIGN KEY ("commentid") REFERENCES comments ("publicationid") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "FK_answercomments_answers"
    FOREIGN KEY ("answerid") REFERENCES answers ("publicationid") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tags
(
    tagid SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    CONSTRAINT valid_tag CHECK(CHAR_LENGTH(name) >= 3 AND CHAR_LENGTH(name) <= 30)
);

CREATE TABLE votes
(
    voteid SERIAL PRIMARY KEY,
    values INTEGER DEFAULT 0 NOT NULL,
    publicationid INTEGER NOT NULL,
    userid INTEGER NOT NULL, -- user that voted
    CONSTRAINT vote_values CHECK(values = 0 OR values = 1 OR values = -1),
    CONSTRAINT "FK_Vote_Publication"
    FOREIGN KEY ("publicationid") REFERENCES publications ("publicationid") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "FK_Vote_User"
    FOREIGN KEY ("userid") REFERENCES users ("userid") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX ixfk_user_votes ON votes USING btree (userid);

CREATE TABLE questiontags (
    questionid INTEGER NOT NULL,
    tagid INTEGER NOT NULL,
    PRIMARY KEY(questionid,tagid),
    CONSTRAINT "Tag"
    FOREIGN KEY ("tagid") REFERENCES tags ("tagid") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Question"
    FOREIGN KEY ("questionid") REFERENCES questions ("publicationid") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE INDEX ixfk_questions_tags_tags ON questiontags USING btree (tagid);

CREATE TABLE userbadges (
    userid INTEGER NOT NULL,
    badgeid INTEGER NOT NULL,
    PRIMARY KEY(userid,badgeid),
    CONSTRAINT "Badge"
    FOREIGN KEY ("badgeid") REFERENCES badges ("badgeid") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "User"
    FOREIGN KEY ("userid") REFERENCES users ("userid") ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE INDEX ixfk_user_badges ON userbadges USING btree (badgeid);


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

create or replace function count_vote_rating_received_user(puser_id integer) returns integer
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


---- Function that returns important info about one user puser_id

CREATE OR REPLACE FUNCTION user_profile(puser_id int)
    RETURNS TABLE (
        fullname character varying(200),
        username character varying(50),
        email character varying(70),
        about character varying(200),
        location character varying(100),
        role character varying(10),
    --badge character varying(50),
        created_at date,
        avatar character varying(256),
        count_votes_rating_received INT,
        count_questions BIGINT,
        count_answers BIGINT,
        count_comments BIGINT,
        count_votes_made BIGINT
    ) AS $func$
BEGIN
    RETURN QUERY
    SELECT users.fullname, users.username, users.email, users.about,
        (SELECT locations.name FROM locations WHERE users.locationid = locations.locationid),
        (SELECT rolename FROM users INNER JOIN userroles ON users.roleid = userroles.roleid WHERE userid = puser_id),
        users.signup_date,
        users.avatar,
        count_vote_rating_received_user(puser_id),
        (SELECT COUNT(*) FROM questions
            INNER JOIN publications
                ON questions.publicationid = publications.publicationid
        WHERE publications.userid = puser_id),
        (SELECT COUNT(*) FROM answers
            INNER JOIN publications
                ON answers.publicationid = publications.publicationid
        WHERE publications.userid = puser_id),
        (SELECT COUNT(*) FROM comments
            INNER JOIN publications
                ON comments.publicationid = publications.publicationid
        WHERE publications.userid = puser_id),
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


--- This function updates the column last_edit_date with the current timestamp everytime there is an update on the table

DROP TRIGGER IF EXISTS answer_update_question_timestamp ON public.publications;

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

--- This function adds does two inserts : - INSERT INTO Questions and Publications //FIXME THIS SOULD BE A TRANSACTION

CREATE OR REPLACE FUNCTION insert_into_questions(body text, userid integer, title varchar, categoryid integer)
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

CREATE OR REPLACE FUNCTION top_scored_questions(skip integer, limitnumber integer)
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


CREATE OR REPLACE FUNCTION unanswered_questions(skip integer, limitnumber integer)
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

CREATE OR REPLACE FUNCTION insert_into_answers(userid INTEGER, questionid INTEGER, body text)
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


--- This function updates questions -> edit_question

CREATE OR REPLACE FUNCTION update_question(body_edited text, questionid integer, title_edited varchar, categoryid_edited integer)
    returns void language plpgsql as $$
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


--- This function creates a new comment //FIXME this should be a transaction!

CREATE OR REPLACE FUNCTION insert_into_answercomments(userid INTEGER, answerid INTEGER, body text)
    returns void language plpgsql as $$
DECLARE result INTEGER;
begin
    insert into publications(body, userid)
    VALUES (body, userid)
    returning publications.publicationid AS publicationid INTO result;

    insert into comments(publicationid) VALUES (result);

    insert into answercomments(commentid, answerid) VALUES (result, answerid);
end $$;

-- This function returns the question details from a given user id


CREATE OR REPLACE FUNCTION get_questions_by_user_id (uid INTEGER, skip integer, limitnumber integer)
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
LANGUAGE plpgsql
AS $func$
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
$func$;

CREATE OR REPLACE FUNCTION update_user_profile(uid integer, full_name varchar, e_mail varchar, location varchar, about_user text, avatar varchar)
    returns void language plpgsql as $$
begin
    UPDATE users
    SET fullname = full_name, email = e_mail, about = about_user, locationid = (SELECT locationid FROM locations WHERE locations.name = location), users.avatar = avatar
    WHERE userid = uid;
end $$;

---- This function returns the comments of a given answer

CREATE OR REPLACE FUNCTION get_answer_comments (aid INTEGER)
  RETURNS TABLE (
    questionid INTEGER,
    answerid INTEGER,
    publicationid INTEGER,
    body TEXT,
    creation_date TIMESTAMP,
    userid INTEGER,
    username VARCHAR(50)

  )
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

---- This function returns the comments of a given question

CREATE OR REPLACE FUNCTION get_question_comments (qid INTEGER)
  RETURNS TABLE (
    questionid INTEGER,
    publicationid INTEGER,
    body TEXT,
    creation_date TIMESTAMP,
    userid INTEGER,
    username VARCHAR(50)

  )
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


CREATE OR REPLACE FUNCTION top_scored_users()
    RETURNS TABLE (
        userid INTEGER,
        username character varying(50),
        avatar character varying(256),
    --badge character varying(50),
        count_votes_rating_received INT,
        count_questions INT,
        count_answers INT,
        count_comments INT
    ) AS $func$
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
$func$  LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION user_total_questions(puser_id INT)
    returns integer
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

CREATE OR REPLACE FUNCTION user_total_answers(puser_id INT)
    returns integer
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

CREATE OR REPLACE FUNCTION user_total_comments(puser_id INT)
    returns integer
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

CREATE OR REPLACE FUNCTION get_users_pag(skip INTEGER, limitNumber INTEGER)
    RETURNS TABLE (
        userid INTEGER,
        roleid INTEGER,
        rolename VARCHAR(25),
        username VARCHAR(25),
        email VARCHAR(25),
        bancount BIGINT
    )
AS $func$
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
$func$  LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION category_questions(skip INTEGER, limitNumber INTEGER, cid INTEGER)
  RETURNS TABLE (
    publicationid INTEGER,
    name VARCHAR,
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
$func$  LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION answer_ranking(aid INT)
RETURNS INTEGER
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

CREATE OR REPLACE FUNCTION answer_total_comments(aid INT)
    returns integer
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

CREATE OR REPLACE FUNCTION answer_details_from_id (aid INTEGER)
  RETURNS TABLE (
    publicationid INTEGER,
    body TEXT,
    questionid INTEGER,
    title VARCHAR(100),
    creation_date TIMESTAMP,
    solved_date TIMESTAMP,
    username VARCHAR(10),
    userid INTEGER,
    votes_count BIGINT)
AS $func$
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
$func$  LANGUAGE plpgsql;


create or replace function mark_as_solved(aid INTEGER, qid INTEGER)
    returns void language plpgsql as $$
DECLARE result INTEGER;
begin
    UPDATE answers SET solved_date= NOW() WHERE publicationid= aid;
    UPDATE questions SET solved_date = NOW() WHERE publicationid = qid;
end $$;

create or replace function delete_solved(aid INTEGER, qid INTEGER)
    returns void language plpgsql as $$
DECLARE result INTEGER;
begin
    UPDATE answers SET solved_date= NULL WHERE publicationid= aid;
    UPDATE questions SET solved_date = NULL WHERE publicationid = qid;
end $$;

CREATE OR REPLACE FUNCTION is_answer_accepted(aid INT)
    returns INTEGER
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

create or replace function insert_into_questioncomments(userid INTEGER, questionid INTEGER, body text)
    returns void language plpgsql as $$
DECLARE result INTEGER;
BEGIN
    insert into publications(body, userid)
    VALUES (body, userid)
    returning publications.publicationid AS publicationid INTO result;

    insert into comments(publicationid) VALUES (result);

    insert into questioncomments(commentid, questionid) VALUES (result, questionid);
END $$;

CREATE OR REPLACE FUNCTION get_publication_rating (pid INTEGER)
    RETURNS INTEGER
LANGUAGE plpgsql
AS $func$
DECLARE rating INTEGER;
BEGIN
    SELECT SUM(votes.values) AS rating FROM votes WHERE votes.publicationid = pid
    INTO rating;
    RETURN rating;
END
$func$;

CREATE OR REPLACE FUNCTION related_questions(cid integer, qid integer)
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
    WHERE questions.categoryid = cid AND questions.publicationid != qid
  ORDER BY votes_count DESC
  LIMIT 5;
END
$$;

create or replace function delete_question(qid INTEGER)
    returns void language plpgsql as $$
DECLARE result INTEGER;
begin
    DELETE FROM questions WHERE questions.publicationid = qid;
    DELETE FROM publications WHERE publications.publicationid = qid;
end $$;

CREATE OR REPLACE FUNCTION search_publications(psearch text)
  RETURNS TABLE (pid INTEGER, score_pub REAL) AS $func$
BEGIN
  return QUERY
  SELECT DISTINCT publications.publicationid as pubs, ts_rank_cd(
      to_tsvector('english', publications.body),
      plainto_tsquery('english', psearch)
  ) AS score_pub
  FROM publications
  WHERE to_tsvector('english', publications.body) @@ plainto_tsquery('english', psearch) ;
END
$func$  LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_questions(psearch text)
  RETURNS TABLE (questionid INTEGER, score_question REAL) AS $func$
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
$func$  LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION search_answers(psearch text)
  RETURNS TABLE (answerid INTEGER, score_answer REAL) AS $func$
BEGIN
  return QUERY
  SELECT publications.publicationid as answers, ts_rank_cd(to_tsvector('english', publications.body),
                                                           plainto_tsquery('english', psearch)) AS score_answer
  FROM publications LEFT OUTER JOIN answers ON publications.publicationid = answers.publicationid
  WHERE to_tsvector('english', publications.body) @@ plainto_tsquery('english', psearch)
  AND answers.publicationid IN (SELECT DISTINCT publications.publicationid as pubs FROM publications
  WHERE to_tsvector('english', publications.body) @@ plainto_tsquery('english', psearch));

END
$func$  LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION search_users(psearch text)
  RETURNS TABLE (userid INTEGER, username VARCHAR(50), score_answer REAL) AS $func$
BEGIN
  return QUERY
  SELECT users.userid, users.username as users, ts_rank_cd(to_tsvector('english', users.username),
                                                           plainto_tsquery('english', psearch)) AS score_user
  FROM users
  WHERE to_tsvector('english', users.username) @@ plainto_tsquery('english', psearch);
END
$func$  LANGUAGE plpgsql;

---

CREATE OR REPLACE FUNCTION category_questions(skip INTEGER, limitNumber INTEGER, cid INTEGER)
  RETURNS TABLE (
    publicationid INTEGER,
    name VARCHAR,
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
$func$  LANGUAGE plpgsql;


------

CREATE OR REPLACE FUNCTION search_tags(psearch text)
  RETURNS TABLE (tid INTEGER, score_tag REAL) AS $func$
BEGIN
  return QUERY
  SELECT DISTINCT tags.tagid as pubs, ts_rank_cd(
      to_tsvector('english', tags.name),
      plainto_tsquery('english', psearch)
  ) AS score_pub
  FROM tags
  WHERE to_tsvector('english', tags.name) @@ plainto_tsquery('english', psearch) ;
END
$func$  LANGUAGE plpgsql;


-----------

CREATE OR REPLACE FUNCTION get_questions_from_tagid(skip INTEGER, limitNumber INTEGER, tid INTEGER)
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
    INNER JOIN questiontags ON questions.publicationid = questiontags.questionid
    LEFT JOIN users ON publications.userid = users.userid
  WHERE questiontags.tagid = tid
  LIMIT limitNumber
  OFFSET skip;
END
$func$  LANGUAGE plpgsql;
