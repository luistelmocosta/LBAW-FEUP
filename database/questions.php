<?php

function create_question($question) {

    global $conn;
    $query_publications=$conn->prepare("SELECT * FROM insert_into_questions(:body, :userid, :title, :categoryid);
");
    $query_publications->execute($question);

    return (int)$conn->lastInsertId();
}

function update_question($question) {
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM update_question(:body, :questionid, :title, :categoryid)");
    $stmt->execute($question);
    return true;
}

function get_categories() {
    global $conn;
    $query=$conn->prepare("SELECT categories.categoryid, categories.name, COUNT(questions.categoryid) as total FROM questions 
RIGHT OUTER JOIN categories 
ON questions.categoryid = categories.categoryid 
GROUP BY name, categories.categoryid 
ORDER BY total DESC; ");
    $query->execute();
    return $query->fetchAll();
}

function get_all_categories() {
    global $conn;
    $query=$conn->prepare("SELECT categories.name FROM categories ; ");
    $query->execute();
    return $query->fetchAll();
}

function get_categoryID_by_name($category) {
    global $conn;
    $query=$conn->prepare("SELECT categoryid FROM categories WHERE name = ?");
    $query->execute(array($category));


    return ($query->fetch()['categoryid']);
}

function get_publication_rating($pubid) {
    global $conn;
    $query=$conn->prepare("SELECT get_publication_rating FROM get_publication_rating(:pubid)");
    $query->execute(array($pubid));


    return $query->fetch();
}

function update_tags($questionid, $tags) {
    global $conn;

    //Check if question already exists. If Yes, delete it from the array -> //EDIT PROPOSES
    $questiontags = get_all_tags();
    $existant_tags = [];

    foreach ($questiontags as $tag_idx => $tag) {
        if(in_array($tag['name'], $tags)){
            $key = array_search($tag['name'], $tags);
            unset($tags[$key]);
            $existant_tags[] = $tag['tagid'];
            associate_only_tag($tag['tagid'], $questionid);

        }
        $questiontags[$tag_idx] = $tag['tagid'];
    }

    foreach ($tags as $tag) {
        associate_tag($tag, $questionid);
    }

    $tags_to_delete = array_diff($questiontags, $existant_tags);

    foreach ($tags_to_delete as $tagid) {
        delete_tag_from_question($tagid, $questionid);
    }
}

function update_tags_edit($questionid, $tags) {
    global $conn;

    //Check if question already exists. If Yes, delete it from the array -> //EDIT PROPOSES
    $questiontags = get_all_tags();
    $existant_tags = [];

    foreach ($questiontags as $tag_idx => $tag) {
        if(in_array($tag['name'], $tags)){
            $key = array_search($tag['name'], $tags);
            unset($tags[$key]);
            $existant_tags[] = $tag['tagid'];
            update_question_tag($tag['tagid'], $questionid);

        }
        $questiontags[$tag_idx] = $tag['tagid'];
    }

    foreach ($tags as $tag) {
        associate_tag($tag, $questionid);
    }

    $tags_to_delete = array_diff($questiontags, $existant_tags);

    foreach ($tags_to_delete as $tagid) {
        delete_tag_from_question($tagid, $questionid);
    }
}

function get_all_tags() {

    global $conn;

    $query=$conn->prepare("SELECT tags.tagid, tags.name FROM tags ");
    $query->execute();

    return $query->fetchAll();

}

function get_tags_from_question($questionid) {
    global $conn;

    $query=$conn->prepare("SELECT tags.tagid, tags.name FROM tags 
INNER JOIN questiontags 
ON tags.tagid = questiontags.tagid
WHERE questiontags.questionid = :question
");
    $query->execute(['question' => $questionid]);

    return $query->fetchAll();
}

function insert_tag($tag)
{
    global $conn;
    $stmt = $conn->prepare("INSERT INTO tags (name) VALUES(:tag)");
    $stmt->execute([$tag]);
    return (int)$conn->lastInsertId();
}

function associate_tag($tag, $questionid)
{
    global $conn;
    $tagid = insert_tag($tag);
    $stmt = $conn->prepare("INSERT INTO questiontags (questionid, tagid) VALUES(:question, :tag)");
    $stmt->execute(['question' => $questionid, 'tag' => $tagid]);
}

function associate_only_tag($tagid, $questionid)
{
    global $conn;
    $stmt = $conn->prepare("INSERT INTO questiontags (questionid, tagid) VALUES(:question, :tag)");
    $stmt->execute(['question' => $questionid, 'tag' => $tagid]);
}



function delete_tag_from_question($tagid, $questionid) {
    global $conn;

    $query = $conn->prepare("DELETE FROM questiontags WHERE questionid = :question AND tagid = :tag");
    $query->execute(['question' => $questionid, 'tag' => $tagid]);
}

function recent_questions($page = 0)
{
    global $conn;
    $limit = 4;
    $skip = $limit * $page;
    $stmt = $conn->prepare("SELECT * FROM recent_questions(:skip, :limit)");
    $stmt->execute(['limit' => $limit, 'skip' => $skip]);
    $rows = $stmt->fetchAll();
    //$rows = addQuestionsComputedFields($rows);

    return $rows;
}

function getQuestionsPag($skip, $limit)
{
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM recent_questions(:skip, :limit)");
    $stmt->execute(['limit' => $limit, 'skip' => $skip]);
    $rows = $stmt->fetchAll();

    return $rows;
}

function unanswered_questions($page = 0) {

    global $conn;
    $limit = 4;
    $skip = $limit * $page;
    $stmt = $conn->prepare("SELECT * FROM unanswered_questions(:skip, :limit) WHERE answers_count = 0");
    $stmt->execute(['limit' => $limit, 'skip' => $skip]);
    $rows = $stmt->fetchAll();
    //$rows = addQuestionsComputedFields($rows);

    return $rows;
}

function top($page = 0) {

    global $conn;
    $limit = 7;
    $skip = $limit * $page;
    $stmt = $conn->prepare("SELECT * FROM top_scored_questions(:skip, :limit)");
    $stmt->execute(['limit' => $limit, 'skip' => $skip]);
    $rows = $stmt->fetchAll();
    //$rows = addQuestionsComputedFields($rows);

    return $rows;
}

function get_questions_from_id($publicationid) {
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM question_details_from_id(:publicationid)");
    $stmt->execute(['publicationid' => $publicationid]);
    $rows = $stmt->fetchAll();
    return $rows;
}

function update_question_tag($tagid, $questionid)
{
    global $conn;
    $stmt = $conn->prepare("BEGIN;");
    $stmt->execute();
    $stmt = $conn->prepare("LOCK TABLE questiontags IN SHARE ROW EXCLUSIVE MODE;");
    $stmt->execute();
    $stmt = $conn->prepare("INSERT INTO questiontags (questionid, tagid)
        SELECT :questionid,:tagid WHERE NOT exists(
            SELECT questionid,tagid from questiontags where questionid=:questionid and tagid=:tagid
        )");
    $stmt->execute(['questionid' => $questionid, 'tagid' => $tagid]);
    $stmt = $conn->prepare("COMMIT;");
    $stmt->execute();
}

function increment_views_counter($questionid) {
    global $conn;
    $stmt = $conn->prepare("UPDATE questions SET views_counter=views_counter+1 WHERE publicationid = :questionid");
    $stmt->execute(['questionid' => $questionid]);
}

function get_answers_from_questionid($questionid) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM answers_from_questionid(:questionid)");
    $stmt->execute(['questionid' => $questionid]);
    $rows = $stmt->fetchAll();
    return $rows;
}

function get_questions_by_user_id($userid, $page = 0) {

    global $conn;
    $limit = 4;
    $skip = $limit * $page;
    $stmt = $conn->prepare("SELECT * FROM get_questions_by_user_id(:userid, :skip, :limit)");
    $stmt->execute(['userid' => $userid, 'limit' => $limit, 'skip' => $skip]);
    $rows = $stmt->fetchAll();

    return $rows;
}

function question_is_mine($question)
{
    if (!$_SESSION['logged_in']) {
        return false;
    }
    return $question['userid'] == auth_user('userid');
}


function question_voted_by_me($question)
{
    if (!$_SESSION['logged_in']) {
        return false;
    }
    return $question['userid'] == auth_user('userid');
}

function search_questions($pstext){
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM questions WHERE questions.publicationid = (SELECT questionid FROM search_questions(:pstext) WHERE questions.publicationid = questionid)");
    $stmt->execute(['pstext' => $pstext]);
    $rows = $stmt->fetchAll();

    return $rows;
}

function search_answers($pstext){
    global $conn;
    $stmt = $conn->prepare("SELECT answerid FROM search_answers(:pstext)");
    $stmt->execute(['pstext' => $pstext]);
    $rows = $stmt->fetchAll();

    return $rows;
}

function search_tags($pstext){
    global $conn;
    $stmt = $conn->prepare("SELECT tid FROM search_tags(:pstext)");
    $stmt->execute(['pstext' => $pstext]);
    $rows = $stmt->fetchAll();

    return $rows;
}

function get_questions_w_body(){
    global $conn;
    $stmt = $conn->prepare("select questions.*, publications.body from questions, publications where questions.publicationid = publications.publicationid");
    $stmt->execute();
    $rows = $stmt->fetchAll();

    return $rows;
}

function getNumQuestions(){
    global $conn;
    $stmt = $conn->prepare("SELECT COUNT(*) FROM questions");
    $stmt->execute();

    return $stmt->fetchAll();
}

function getNumAnswers(){
    global $conn;
    $stmt = $conn->prepare("SELECT COUNT(*) FROM answers");
    $stmt->execute();

    return $stmt->fetchAll();
}

function getNumComments(){
    global $conn;
    $stmt = $conn->prepare("SELECT COUNT(*) FROM comments");
    $stmt->execute();

    return $stmt->fetchAll();
}

function getNumUnsolved(){
    global $conn;
    $stmt = $conn->prepare("SELECT COUNT(*) FROM questions WHERE questions.solved_date IS null");
    $stmt->execute();

    return $stmt->fetchAll();
}

function delete_question($questionid)
{
    global $conn;
    $query = $conn->prepare("SELECT * FROM delete_question(:questionid)");
    $query->execute(['questionid' => $questionid]);
}

function delete_question_as_solved($qid) {
    global $conn;
    $stmt = $conn->prepare("UPDATE questions SET solved_date = NULL WHERE questions.publicationid=:qid");
    $stmt->execute(['qid' => $qid]);
}

function delete_answer_as_solved($aid, $qid) {
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM delete_solved(:aid, :qid)");
    $stmt->execute(['aid' => $aid, 'qid' => $qid]);
}

function delete_all_answer_as_solved($aid) {
    global $conn;
    $stmt = $conn->prepare("UPDATE answers SET solved_date = NULL WHERE questionid=:aid");
    $stmt->execute(['aid' => $aid]);
}

function mark_question_as_solved($aid, $qid) {
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM mark_as_solved(:aid, :qid)");
    $stmt->execute(['aid' => $aid, 'qid' => $qid]);
}

function answer_score($aid) {
    global $conn;
    $query=$conn->prepare("SELECT * FROM answer_ranking(:aid)");
    $query->execute(array($aid));


    return $query->fetch();
}

function is_answer_accepted($aid) {
    global $conn;
    $query=$conn->prepare("SELECT is_answer_accepted FROM is_answer_accepted(:aid)");
    $query->execute(array($aid));


    return $query->fetch();
}

function any_answer_accepted($qid) {
    global $conn;
    $query=$conn->prepare("SELECT solved_date FROM answers WHERE answers.questionid = :qid");
    $query->execute(array($qid));


    return $query->fetch();
}

function is_question_accepted($qid) {
    global $conn;
    $query=$conn->prepare("SELECT solved_date FROM questions WHERE questions.publicationid = :qid");
    $query->execute(array($qid));


    return $query->fetch();
}

function related_questions($category, $questionid) {

    global $conn;
    $stmt = $conn->prepare("SELECT * FROM related_questions(:category, :questionid)");
    $stmt->execute(['category' => $category, 'questionid' => $questionid]);
    $rows = $stmt->fetchAll();
    //$rows = addQuestionsComputedFields($rows);

    return $rows;
}

function get_question_categoryid($qid) {
    global $conn;
    $stmt = $conn->prepare("SELECT categories.categoryid FROM questions INNER JOIN categories ON questions.categoryid = categories.categoryid WHERE questions.publicationid = :qid");
    $stmt->execute(array($qid));


    return $stmt->fetch();
}

function category_questions($cid, $page = 0) {

    global $conn;
    $limit = 4;
    $skip = $limit * $page;
    $stmt = $conn->prepare("SELECT * FROM category_questions(:skip, :limit, :cid);");
    $stmt->execute(['limit' => $limit, 'skip' => $skip, 'cid' => $cid]);
    $rows = $stmt->fetchAll();
    //$rows = addQuestionsComputedFields($rows);

    return $rows;
}

function get_questions_from_tagid($tid, $page = 0) {

    global $conn;
    $limit = 4;
    $skip = $limit * $page;
    $stmt = $conn->prepare("SELECT * FROM get_questions_from_tagid(:skip, :limit, :tid)");
    $stmt->execute(['limit' => $limit, 'skip' => $skip, 'tid' => $tid]);
    $rows = $stmt->fetchAll();
    //$rows = addQuestionsComputedFields($rows);

    return $rows;
}