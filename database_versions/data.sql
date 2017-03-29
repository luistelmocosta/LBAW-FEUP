INSERT INTO badges(name, description) VALUES ('Newbie', 'New User. No correct answers');
INSERT INTO badges(name, description) VALUES ('Starter', 'Made one question');
INSERT INTO badges(name, description) VALUES ('Helper', 'Answered a topic');
INSERT INTO badges(name, description) VALUES ('Loyal', 'Have one question marked as accepted');
INSERT INTO badges(name, description) VALUES ('Master', '10 correct answers');


INSERT INTO categories(name) VALUES ('Sports');
INSERT INTO categories(name) VALUES ('Science');
INSERT INTO categories(name) VALUES ('Informatic');
INSERT INTO categories(name) VALUES ('Technology');
INSERT INTO categories(name) VALUES ('Culture');
INSERT INTO categories(name) VALUES ('Others');
INSERT INTO categories(name) VALUES ('Travel');
INSERT INTO categories(name) VALUES ('Health');

INSERT INTO userroles(name) VALUES ('Authenticated');
INSERT INTO userroles(name) VALUES ('Admin');
INSERT INTO userroles(name) VALUES ('Editor');

INSERT INTO locations(name) VALUES ('Porto');
INSERT INTO locations(name) VALUES ('Viseu');
INSERT INTO locations(name) VALUES ('Sao Paulo');
INSERT INTO locations(name) VALUES ('Paredes');

INSERT INTO users (username, email, password, locationid, roleid)
VALUES ('editor', 'editor@editor.pt', '12345678', 1, 3);
INSERT INTO users (username, email, password, locationid, roleid)
VALUES ('warneduser', 'warneduser@user.pt', '12345678', 4, 1);
INSERT INTO users (username, email, password, locationid, roleid)
VALUES ('luistelmocosta', 'luistelmocosta@gmail.com', '12345678', 4, 2);
INSERT INTO users (username, email, password, locationid, roleid)
VALUES ('admin', 'admin@admin.pt', '12345678', 4, 2);
INSERT INTO users (username, email, password, locationid, roleid)
VALUES ('member', 'member@member.pt', '12345678', 3, 1);
INSERT INTO users (username, email, password, locationid, roleid)
VALUES ('ronaldo7', 'ronaldo@ronaldo.pt', '12345678', 3, 1);

INSERT INTO modregisters(reason, userid_author, userid_target) VALUES ('Offensive Speech', 3, 4);
INSERT INTO modregisters(reason, userid_author, userid_target) VALUES ('Wrong question structure', 3, 4);
INSERT INTO modregisters(reason, userid_author, userid_target) VALUES ('Bad username', 3, 4);
INSERT INTO modregisters(reason, userid_author, userid_target) VALUES ('Third Warning', 4, 4);

INSERT INTO warnings(warningid) VALUES (2);
INSERT INTO warnings(warningid) VALUES (3);

INSERT INTO bans(banid, end_date) VALUES (2, '2018-03-29 01:05:00');
INSERT INTO bans(banid, end_date) VALUES (4, '2018-04-04 01:05:00');

INSERT INTO publications(body, userid) VALUES ('When is the next full moon?', 3);
INSERT INTO publications(body, userid) VALUES ('What is the cheapest way to go to London?',3);
INSERT INTO publications(body, userid) VALUES ('Do I get pregnant from sitting in public toilets?', 3);
INSERT INTO publications(body, userid) VALUES ('Whos the best football player in the world?', 3);
INSERT INTO publications(body, userid) VALUES ('The next full moon will be on 22nd June 2017', 4);
INSERT INTO publications(body, userid) VALUES ('You should explore Ryanair/EasyJet flight promotions', 4);
INSERT INTO publications(body, userid) VALUES ('Please tell me youre not serious, mate', 4);
INSERT INTO publications(body, userid) VALUES ('That question has no rational answer. Both players are great! Enjoy them while you can!', 4);
INSERT INTO publications(body, userid) VALUES ('Cristiano Ronaldo only thinks about himself', 5);
INSERT INTO publications(body, userid) VALUES ('Cristiano Ronaldo carries his National Team', 6);

INSERT INTO questions(publicationid ,title, categoryid) VALUES (1,'Full Moon', 6);
INSERT INTO questions(publicationid, title, categoryid) VALUES (2, 'Fly to London', 7);
INSERT INTO questions(publicationid, title, categoryid) VALUES (3,'Pregnancy Alarm', 8);
INSERT INTO questions(publicationid, title, categoryid) VALUES (4,'Best FootballPlayer', 1);


INSERT INTO comments(publicationid) VALUES (9);
INSERT INTO comments(publicationid) VALUES (10);

INSERT INTO questioncomments(commentid, questionid) VALUES (9, 4);

INSERT INTO answers(publicationid, questionid) VALUES (5, 1);
INSERT INTO answers(publicationid, questionid) VALUES (6, 2);
INSERT INTO answers(publicationid, questionid) VALUES (7, 3);


INSERT INTO answercomments(commentid, answerid) VALUES (10, 5);

INSERT INTO tags(name) VALUES ('real madrid');
INSERT INTO tags(name) VALUES ('moon');
INSERT INTO tags(name) VALUES ('flights');
INSERT INTO tags(name) VALUES ('pregnancy');
INSERT INTO tags(name) VALUES ('health');
INSERT INTO tags(name) VALUES ('football');

INSERT INTO votes("value", publicationid, userid) VALUES (1, 1, 1);
INSERT INTO votes("value", publicationid, userid) VALUES (0, 1, 2);
INSERT INTO votes("value", publicationid, userid) VALUES (-1, 2, 2);
INSERT INTO votes("value", publicationid, userid) VALUES (1, 2, 3);
INSERT INTO votes("value", publicationid, userid) VALUES (1, 3, 3);


INSERT INTO questiontags(questionid, tagid) VALUES (1, 2);
INSERT INTO questiontags(questionid, tagid) VALUES (2, 3);
INSERT INTO questiontags(questionid, tagid) VALUES (3, 4);
INSERT INTO questiontags(questionid, tagid) VALUES (3, 5);
INSERT INTO questiontags(questionid, tagid) VALUES (4, 1);
INSERT INTO questiontags(questionid, tagid) VALUES (4, 6);


INSERT INTO userbadges(userid, badgeid) VALUES (1, 1);
INSERT INTO userbadges(userid, badgeid) VALUES (1, 2);
INSERT INTO userbadges(userid, badgeid) VALUES (1, 3);
INSERT INTO userbadges(userid, badgeid) VALUES (1, 4);
INSERT INTO userbadges(userid, badgeid) VALUES (1, 5);
INSERT INTO userbadges(userid, badgeid) VALUES (2, 1);
INSERT INTO userbadges(userid, badgeid) VALUES (3, 1);
INSERT INTO userbadges(userid, badgeid) VALUES (3, 2);
INSERT INTO userbadges(userid, badgeid) VALUES (4, 1);
INSERT INTO userbadges(userid, badgeid) VALUES (4, 2);
INSERT INTO userbadges(userid, badgeid) VALUES (4, 3);
INSERT INTO userbadges(userid, badgeid) VALUES (4, 5);







