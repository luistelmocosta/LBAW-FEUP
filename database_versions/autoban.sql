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