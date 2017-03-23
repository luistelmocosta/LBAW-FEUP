CREATE TABLE "Warning"
(
    warningid SERIAL NOT NULL
);

CREATE TABLE "Badge"
(
    badgeid SERIAL NOT NULL,
    description VARCHAR(100) NOT NULL,
    CONSTRAINT badge_description CHECK(char_length(description) >= 10 AND char_length(description) <= 100)
);

CREATE TABLE "Ban"
(
    banid SERIAL NOT NULL,
    end_date TIMESTAMP
);

CREATE TABLE "Category"
(
    categoryid SERIAL NOT NULL,
    name VARCHAR(100) NOT NULL,
    CONSTRAINT valid_category CHECK(char_length(name) >= 3 AND char_length(name) <= 50)

);

CREATE TABLE "Comment"
(
    commentid SERIAL NOT NULL
);

CREATE TABLE "CommentQuestion"
(
    commentid SERIAL NOT NULL,
    questionid INTEGER NOT NULL
);

CREATE TABLE "CommentAnswer"
(
    commentid SERIAL NOT NULL,
    answerid INTEGER NOT NULL
);

CREATE TABLE "Location"
(
    locationid SERIAL NOT NULL,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE "Question"
(
    questionid SERIAL NOT NULL,
    title VARCHAR(100) NOT NULL,
    categoryid INTEGER NOT NULL,
    solved_date TIMESTAMP,
    CONSTRAINT title_length CHECK (char_length(title) >= 3 AND char_length(title) <= 50) 
);


CREATE TABLE "Publication"
(
    publicationid SERIAL NOT NULL,
    body VARCHAR(1000) NOT NULL ,
    creation_date TIMESTAMP DEFAULT now() NOT NULL,
    userid INTEGER NOT NULL,
    CONSTRAINT body_length CHECK (char_length(body) >= 10 AND char_length(body) <= 1000)
);

CREATE TABLE "ModRegister"
(
    modregisterid SERIAL NOT NULL,
    date_creation TIMESTAMP DEFAULT now() NOT NULL,
    reason VARCHAR(200) NOT NULL,
    userid INTEGER NOT NULL
);

CREATE TABLE "Answer"
(
    answerid SERIAL NOT NULL,
    questionid INTEGER NOT NULL,
    solved_date TIMESTAMP
);

CREATE TABLE "Tag"
(
    tagid SERIAL NOT NULL,
    name VARCHAR(100) NOT NULL,
    CONSTRAINT valid_tag CHECK(char_length(name) >= 3 AND char_length(name) <= 20)

);

CREATE TABLE "UserRole"
(
    roleid SERIAL NOT NULL,
    name VARCHAR(50) NOT NULL,
    CONSTRAINT user_role CHECK(name IN ('Admin', 'Editor', 'Authenticated'))

);

CREATE TABLE "User"
(
    userid SERIAL NOT NULL,
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
    CONSTRAINT valid_password CHECK(char_length(password) >= 8 AND char_length(password) < 50),
    CONSTRAINT valid_username CHECK(char_length(username) >= 1 AND char_length(username) < 20),
    CONSTRAINT valid_fullname CHECK(char_length(fullname) >= 6 AND char_length(fullname) <= 50),
    CONSTRAINT valid_email CHECK(char_length(email) >= 6 AND char_length(email) <= 50)
);

CREATE TABLE "Vote"
(
    voteid SERIAL NOT NULL,
    value INTEGER DEFAULT 0 NOT NULL,
    publicationid INTEGER NOT NULL,
    userid INTEGER NOT NULL,
    CONSTRAINT vote_values CHECK(value = 0 OR value = 1 OR value = -1)

);

CREATE TABLE "QuestionTag" (
    questionid INTEGER NOT NULL,
    tagid INTEGER NOT NULL
);

CREATE TABLE "UserBadge" (
    userid INTEGER NOT NULL,
    badgeid INTEGER NOT NULL
);



ALTER TABLE "Warning" ADD CONSTRAINT "PK_Warning"
	PRIMARY KEY ("warningid");

ALTER TABLE "Badge" ADD CONSTRAINT "PK_Badge"
	PRIMARY KEY ("badgeid");

ALTER TABLE "Ban" ADD CONSTRAINT "PK_Ban"
	PRIMARY KEY ("banid");

ALTER TABLE "Category" ADD CONSTRAINT "PK_Category"
	PRIMARY KEY ("categoryid");

ALTER TABLE "Comment" ADD CONSTRAINT "PK_Comment"
	PRIMARY KEY ("commentid");

ALTER TABLE "CommentQuestion" ADD CONSTRAINT "PK_CommentQuestion"
	PRIMARY KEY ("commentid");

ALTER TABLE "CommentAnswer" ADD CONSTRAINT "PK_CommentAnswer"
	PRIMARY KEY ("commentid");

ALTER TABLE "Location" ADD CONSTRAINT "PK_Location"
	PRIMARY KEY ("locationid");

ALTER TABLE "Question" ADD CONSTRAINT "PK_Question"
	PRIMARY KEY ("questionid");

ALTER TABLE "Publication" ADD CONSTRAINT "PK_Publication"
	PRIMARY KEY ("publicationid");

ALTER TABLE "ModRegister" ADD CONSTRAINT "PK_RegistosModeracao"
	PRIMARY KEY ("modregisterid");

ALTER TABLE "Answer" ADD CONSTRAINT "PK_Answer"
	PRIMARY KEY ("answerid");

ALTER TABLE "Tag" ADD CONSTRAINT "PK_Tag"
	PRIMARY KEY ("tagid");

ALTER TABLE "UserRole" ADD CONSTRAINT "PK_UserRole"
	PRIMARY KEY ("roleid");

ALTER TABLE "User" ADD CONSTRAINT "PK_User"
	PRIMARY KEY ("userid");

ALTER TABLE "Vote" ADD CONSTRAINT "PK_Vote"
	PRIMARY KEY ("voteid");

ALTER TABLE "Warning" ADD CONSTRAINT "FK_Warning_ModRegister"
	FOREIGN KEY ("warningid") REFERENCES "ModRegister" ("modregisterid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Ban" ADD CONSTRAINT "FK_Ban_ModRegister"
	FOREIGN KEY ("banid") REFERENCES "ModRegister" ("modregisterid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Comment" ADD CONSTRAINT "FK_Comment_Publication"
	FOREIGN KEY ("commentid") REFERENCES "Publication" ("publicationid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "CommentQuestion" ADD CONSTRAINT "FK_CommentQuestion_Comment"
	FOREIGN KEY ("commentid") REFERENCES "Comment" ("commentid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "CommentQuestion" ADD CONSTRAINT "FK_CommentQuestion_Question"
	FOREIGN KEY ("questionid") REFERENCES "Question" ("questionid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "CommentAnswer" ADD CONSTRAINT "FK_CommentAnswer_Comment"
	FOREIGN KEY ("commentid") REFERENCES "Comment" ("commentid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "CommentAnswer" ADD CONSTRAINT "FK_CommentAnswer_Answer"
	FOREIGN KEY ("answerid") REFERENCES "Answer" ("answerid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "QuestionTag" ADD CONSTRAINT "Tag"
	FOREIGN KEY ("tagid") REFERENCES "Tag" ("tagid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "QuestionTag" ADD CONSTRAINT "Question"
	FOREIGN KEY ("questionid") REFERENCES "Question" ("questionid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "UserBadge" ADD CONSTRAINT "Badge"
	FOREIGN KEY ("badgeid") REFERENCES "Badge" ("badgeid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "UserBadge" ADD CONSTRAINT "User"
	FOREIGN KEY ("userid") REFERENCES "User" ("userid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Question" ADD CONSTRAINT "FK_Question_Category"
	FOREIGN KEY ("categoryid") REFERENCES "Category" ("categoryid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Question" ADD CONSTRAINT "FK_Question_Publication"
	FOREIGN KEY ("questionid") REFERENCES "Publication" ("publicationid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Publication" ADD CONSTRAINT "FK_Publication_User"
	FOREIGN KEY ("userid") REFERENCES "User" ("userid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "ModRegister" ADD CONSTRAINT "usertomod"
	FOREIGN KEY ("userid") REFERENCES "User" ("userid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "ModRegister" ADD CONSTRAINT "frommod"
	FOREIGN KEY ("userid") REFERENCES "User" ("userid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Answer" ADD CONSTRAINT "FK_Answer_Question"
	FOREIGN KEY ("questionid") REFERENCES "Question" ("questionid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Answer" ADD CONSTRAINT "FK_Answer_Publication"
	FOREIGN KEY ("answerid") REFERENCES "Publication" ("publicationid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "User" ADD CONSTRAINT "FK_User_Location"
	FOREIGN KEY ("locationid") REFERENCES "Location" ("locationid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "User" ADD CONSTRAINT "FK_User_UserRole"
	FOREIGN KEY ("roleid") REFERENCES "UserRole" ("roleid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Vote" ADD CONSTRAINT "FK_Vote_Publication"
	FOREIGN KEY ("publicationid") REFERENCES "Publication" ("publicationid") ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE "Vote" ADD CONSTRAINT "FK_Vote_User"
	FOREIGN KEY ("userid") REFERENCES "User" ("userid") ON DELETE CASCADE ON UPDATE CASCADE;