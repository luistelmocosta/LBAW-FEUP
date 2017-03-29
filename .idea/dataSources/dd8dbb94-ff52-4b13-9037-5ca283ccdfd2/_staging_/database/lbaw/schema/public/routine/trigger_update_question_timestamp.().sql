create function trigger_update_question_timestamp() returns trigger
LANGUAGE plpgsql
AS $$
BEGIN
  UPDATE publications SET last_edit_date = now() WHERE publicationid = NEW.publicationid;
  RETURN NULL;
END;
$$;
