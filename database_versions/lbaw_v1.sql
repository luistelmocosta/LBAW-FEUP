

CREATE TABLE badges
(
    badgeid SERIAL PRIMARY KEY,
    description VARCHAR(100) NOT NULL,
    CONSTRAINT badge_description CHECK(CHAR_LENGTH(description) >= 10 AND CHAR_LENGTH(description) <= 100)
);


CREATE TABLE categories
(
    categoryid SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    CONSTRAINT valid_category CHECK(CHAR_LENGTH(name) >= 3 AND CHAR_LENGTH(name) <= 50)
);




CREATE TABLE userroles
(
    roleid SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    CONSTRAINT user_role CHECK(name IN ('Admin', 'Editor', 'Authenticated'))
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
    password VARCHAR(50) NOT NULL,
    fullname VARCHAR(200),
    about VARCHAR(500),
    website VARCHAR(150),
    signup_date DATE DEFAULT CURRENT_DATE NOT NULL,
    last_login TIMESTAMP,
    locationid INTEGER NOT NULL,
    roleid INTEGER NOT NULL,
    CONSTRAINT valid_date CHECK(last_login > signup_date),
    CONSTRAINT valid_password CHECK(CHAR_LENGTH(password) >= 8 AND CHAR_LENGTH(password) < 50),
    CONSTRAINT valid_username CHECK(CHAR_LENGTH(username) >= 1 AND CHAR_LENGTH(username) < 20),
    CONSTRAINT valid_fullname CHECK(CHAR_LENGTH(fullname) >= 6 AND CHAR_LENGTH(fullname) <= 50),
    CONSTRAINT valid_email CHECK(CHAR_LENGTH(email) >= 6 AND CHAR_LENGTH(email) <= 50),
    CONSTRAINT "FK_User_Location"
        FOREIGN KEY ("locationid") REFERENCES locations ("locationid") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "FK_User_UserRole"
        FOREIGN KEY ("roleid") REFERENCES userroles ("roleid") ON DELETE SET NULL ON UPDATE CASCADE
);

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

CREATE TABLE warnings
(
    warningid SERIAL PRIMARY KEY,
    CONSTRAINT "FK_warnings_modregisters"
        FOREIGN KEY ("warningid") REFERENCES modregisters ("modregisterid") ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE bans
(
    banid SERIAL PRIMARY KEY,
    end_date TIMESTAMP,
    CONSTRAINT "FK_Ban_ModRegister"
       FOREIGN KEY ("banid") REFERENCES modregisters ("modregisterid") ON DELETE CASCADE ON UPDATE CASCADE
);




CREATE TABLE publications
(
    publicationid SERIAL PRIMARY KEY,
    body VARCHAR(1000) NOT NULL ,
    creation_date TIMESTAMP DEFAULT now() NOT NULL,
    userid INTEGER NOT NULL,
    CONSTRAINT body_length CHECK (CHAR_LENGTH(body) >= 10 AND CHAR_LENGTH(body) <= 1000),
    CONSTRAINT "FK_publications_users"
        FOREIGN KEY ("userid") REFERENCES users ("userid") ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE questions
(
    questionid SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    categoryid INTEGER NOT NULL,
    solved_date TIMESTAMP,
    CONSTRAINT title_length CHECK (CHAR_LENGTH(title) >= 3 AND CHAR_LENGTH(title) <= 50),
    CONSTRAINT "FK_Question_Category"
        FOREIGN KEY ("categoryid") REFERENCES categories ("categoryid") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "FK_Question_Publication"
        FOREIGN KEY ("questionid") REFERENCES publications ("publicationid") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE comments
(
    commentid SERIAL PRIMARY KEY,
    CONSTRAINT "FK_Comment_Publication"
        FOREIGN KEY ("commentid") REFERENCES publications ("publicationid") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE questioncomments
(
    commentid SERIAL PRIMARY KEY,
    questionid INTEGER NOT NULL,
    CONSTRAINT "FK_questioncomments_comments"
        FOREIGN KEY ("commentid") REFERENCES comments ("commentid") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "FK_questioncomments_questions"
        FOREIGN KEY ("questionid") REFERENCES questions ("questionid") ON DELETE CASCADE ON UPDATE CASCADE
);




CREATE TABLE answers
(
    answerid SERIAL PRIMARY KEY,
    questionid INTEGER NOT NULL,
    solved_date TIMESTAMP,
    CONSTRAINT "FK_answers_questions"
        FOREIGN KEY ("questionid") REFERENCES questions ("questionid") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "FK_answers_publications"
        FOREIGN KEY ("answerid") REFERENCES publications ("publicationid") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE answercomments
(
    commentid SERIAL PRIMARY KEY,
    answerid INTEGER NOT NULL,
    CONSTRAINT "FK_answercomments_comments"
        FOREIGN KEY ("commentid") REFERENCES comments ("commentid") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "FK_answercomments_answers"
        FOREIGN KEY ("answerid") REFERENCES answers ("answerid") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE tags
(
    tagid SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    CONSTRAINT valid_tag CHECK(CHAR_LENGTH(name) >= 3 AND CHAR_LENGTH(name) <= 20)
);





CREATE TABLE votes
(
    voteid SERIAL PRIMARY KEY,
    VALUE INTEGER DEFAULT 0 NOT NULL,
    publicationid INTEGER NOT NULL,
    userid INTEGER NOT NULL,
    CONSTRAINT vote_values CHECK(VALUE = 0 OR VALUE = 1 OR VALUE = -1),
    CONSTRAINT "FK_Vote_Publication"
        FOREIGN KEY ("publicationid") REFERENCES publications ("publicationid") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "FK_Vote_User"
        FOREIGN KEY ("userid") REFERENCES users ("userid") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE questiontags (
    questionid INTEGER NOT NULL,
    tagid INTEGER NOT NULL,
    PRIMARY KEY(questionid,tagid),
    CONSTRAINT "Tag"
        FOREIGN KEY ("tagid") REFERENCES tags ("tagid") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Question"
        FOREIGN KEY ("questionid") REFERENCES questions ("questionid") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE userbadges (
    userid INTEGER NOT NULL,
    badgeid INTEGER NOT NULL,
    PRIMARY KEY(userid,badgeid),
    CONSTRAINT "Badge"
        FOREIGN KEY ("badgeid") REFERENCES badges ("badgeid") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "User"
        FOREIGN KEY ("userid") REFERENCES users ("userid") ON DELETE CASCADE ON UPDATE CASCADE
);