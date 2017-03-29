CREATE FUNCTION trigger_auto_ban_on_warning_limit()
  RETURNS "trigger" AS $func$
BEGIN
  IF (SELECT COUNT(*) FROM ModRegister WHERE warnings.user_id = NEW.user_id) = 5 THEN
    INSERT INTO bans (user_id, creator_id, notes) VALUES(NEW.user_id, NULL, 'Automatic ban for warning limit 5 reached');
  END IF;
  RETURN NULL;
END;
$func$  LANGUAGE plpgsql;

CREATE TRIGGER auto_ban_on_warning_limit AFTER INSERT ON warnings
FOR EACH ROW EXECUTE PROCEDURE trigger_auto_ban_on_warning_limit();

CREATE FUNCTION trigger_update_question_timestamp()
  RETURNS "trigger" AS $func$
BEGIN
	UPDATE publications SET last_edit_date = now() WHERE id = NEW.publicationid;
	RETURN NULL;
END;
$func$  LANGUAGE plpgsql;

CREATE TRIGGER answer_update_question_timestamp AFTER INSERT OR UPDATE ON publications
   FOR EACH ROW EXECUTE PROCEDURE trigger_update_question_timestamp();

