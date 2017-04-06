create or replace function insert_into_questions(body text, userid integer, title varchar, categoryid integer)
  returns void language plpgsql as $$
declare
  inserted_id integer;
begin
  insert into publications(body, userid)
  VALUES (body, userid)
  returning publicationid;

  insert into questions(title, categoryid) VALUES (title, categoryid);
end $$;