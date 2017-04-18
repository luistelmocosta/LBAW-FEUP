create function unanswered_questions(skip integer, limitnumber integer) returns TABLE(publicationid integer, title character varying, body text, creation_date timestamp without time zone, solved_date timestamp without time zone, username character varying, userid integer, answers_count bigint, upvotes bigint)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT questions.publicationid, questions.title, publications.body,
    publications.creation_date, questions.solved_date, users.username, users.userid,
    (SELECT COUNT(*) FROM question_answers(questions.publicationid)) AS answers_count,
    (SELECT COUNT (*) FROM votes WHERE votes.values = 1 AND votes.publicationid = 1) AS upvotes
  FROM questions
    INNER JOIN publications
      ON questions.publicationid = publications.publicationid
    LEFT JOIN users ON publications.userid = users.userid
  WHERE questions.solved_date IS NULL
  LIMIT limitNumber
  OFFSET skip;
END
$$;
