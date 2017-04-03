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

