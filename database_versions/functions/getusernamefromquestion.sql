CREATE OR REPLACE FUNCTION getusernamefromquestion(questionid integer)
  RETURNS varchar AS $$
select users.username
from publications
  inner join questions on publications.publicationid = questions.publicationid
  inner join users on publications.userid = users.userid
where questions.publicationid = $1;
SELECT * FROM getusernamefromquestion(questionid := $1);
$$ LANGUAGE SQL;


