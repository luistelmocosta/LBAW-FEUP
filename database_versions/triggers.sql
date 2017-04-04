DROP TRIGGER IF EXISTS check_question ON public.questions;


CREATE OR REPLACE FUNCTION check_question()
  RETURNS "trigger" AS $func$
BEGIN
  IF (SELECT COUNT(*) FROM answers, comments WHERE NEW.publicationid = answers.publicationid
                                                   OR NEW.publicationid = comments.publicationid) > 0 THEN
    RAISE EXCEPTION 'A question cant be an answer or a comment!';
  END IF;
  RETURN NULL;
END;
$func$  LANGUAGE plpgsql;

CREATE TRIGGER check_question BEFORE INSERT ON questions
FOR EACH ROW EXECUTE PROCEDURE check_question();

------------------------------------------------------

DROP TRIGGER IF EXISTS check_answer ON public.answers;


CREATE OR REPLACE FUNCTION check_answer()
  RETURNS "trigger" AS $func$
BEGIN
  IF (SELECT COUNT(*) FROM comments, questions WHERE NEW.publicationid = questions.publicationid
                                                     OR NEW.publicationid = comments.publicationid) > 0 THEN
    RAISE EXCEPTION 'An answer cant be a question or a comment!';
  END IF;
  RETURN NULL;
END;
$func$  LANGUAGE plpgsql;

CREATE TRIGGER check_answer BEFORE INSERT ON answers
FOR EACH ROW EXECUTE PROCEDURE check_answer();

---------------------------------------------------

DROP TRIGGER IF EXISTS check_comment ON public.comments;


CREATE OR REPLACE FUNCTION check_comment()
  RETURNS "trigger" AS $func$
BEGIN
  IF (SELECT COUNT(*) FROM answers, questions WHERE NEW.publicationid = questions.publicationid
                                                    OR NEW.publicationid = answers.publicationid) > 0 THEN
    RAISE EXCEPTION 'A comment cant be a question or an answer!';
  END IF;
  RETURN NULL;
END;
$func$  LANGUAGE plpgsql;

CREATE TRIGGER check_comment BEFORE INSERT ON comments
FOR EACH ROW EXECUTE PROCEDURE check_comment();

------------------------------------------------------------

CREATE OR REPLACE FUNCTION getusernamefromquestion(questionid integer)
  RETURNS varchar AS $$
select users.username
from publications
  inner join questions on publications.publicationid = questions.publicationid
  inner join users on publications.userid = users.userid
where questions.publicationid = $1;
SELECT * FROM getusernamefromquestion(questionid := $1);
$$ LANGUAGE SQL;

------------------------------------------------------------

ALTER TABLE questions ADD COLUMN full_text_index_col tsvector;
UPDATE questions
SET full_text_index_col = to_tsvector('english', COALESCE(title,''));

--------------------------------------------------------------


CREATE TRIGGER questions_tsvector_update_trigger
BEFORE INSERT OR UPDATE ON questions
FOR EACH ROW
EXECUTE PROCEDURE tsvector_update_trigger_column('full_text_index_col','pg_catalog.english', 'title');


---------------------------------------------------------------

CREATE INDEX questions_question_search_idx ON questions
USING gin(full_text_index_col);
CREATE INDEX answers_question_search_idx ON publications USING gin(body);


------------------------------------------------------------------

CREATE OR REPLACE FUNCTION search_questions(psearch text)
  RETURNS TABLE (questionid INTEGER) AS $func$
BEGIN
  return QUERY
  SELECT DISTINCT publications.publicationid
  FROM questions, publications
  WHERE to_tsvector(coalesce(questions.title,'') || ' ' || coalesce(publications.body,'')) @@ to_tsquery(psearch)
        OR questionid IN (
    SELECT DISTINCT(answers.questionid) FROM answers INNER JOIN publications ON answers.publicationid = publications.publicationid
    WHERE to_tsvector(coalesce(publications.body)) @@ to_tsquery(psearch)
  )
  ;
END
$func$  LANGUAGE plpgsql;


-------------------------------------------------------------------


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



-------------------------------------------------------------------------

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

