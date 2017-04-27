create or replace function count_vote_rating_received_user(puser_id integer) returns integer
LANGUAGE plpgsql
AS $$
DECLARE publicationvotecount INTEGER;
BEGIN
    SELECT SUM(votes.values) FROM votes INNER JOIN publications ON votes.publicationid = publications.publicationid
        INNER JOIN users ON publications.userid = users.userid WHERE publications.userid = puser_id
    INTO publicationvotecount;

    IF publicationvotecount is null THEN
        publicationvotecount := 0;
    END IF;

    return publicationvotecount;
END
$$;
