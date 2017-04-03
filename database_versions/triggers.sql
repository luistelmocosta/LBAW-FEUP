--CREATE VIEW users_with_solved_questions AS
  --SELECT * from questions INNER JOIN publications ON questions.publicationid = publications.publicationid
  --WHERE solved_date IS NOT NULL;


CREATE OR REPLACE FUNCTION solved_questions_user()
  RETURNS TABLE (userid INTEGER) AS $func$
BEGIN
  RETURN QUERY
  SELECT COUNT(*) FROM questions INNER JOIN publications ON questions.publicationid = publications.publicationid
  WHERE solved_date IS NOT NULL AND publications.userid=4;
END;

$func$  LANGUAGE plpgsql;



SELECT COUNT(*) FROM answers INNER JOIN publications ON answers.publicationid = publications.publicationid
WHERE solved_date IS NOT NULL AND userid=4;


