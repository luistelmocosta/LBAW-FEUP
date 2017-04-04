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