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