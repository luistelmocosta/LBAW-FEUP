<?php


function create_question($question) {

    global $conn;
    $query_publications=$conn->prepare("SELECT * FROM insert_into_questions(:body, :userid, :title, :categoryid);
");
    $query_publications->execute($question);


    return (int)$conn->lastInsertId();



    /*$query_questions=$conn->prepare("INSERT INTO questions(title, categoryid) VALUES (:title, 1);
");

    $query_questions->execute($query_questions);*/



}

function get_categories() {
    global $conn;
    $query=$conn->prepare("SELECT categories.name FROM categories");
    $query->execute();
    return $query->fetchAll();
}

function get_categoryID_by_name($category) {
    global $conn;
    $query=$conn->prepare("SELECT categoryid FROM categories WHERE name = ?");
    $query->execute(array($category));


    return ($query->fetch()['categoryid']);
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

function update_tags($questionid, $tags) {
    global $conn;

    //Check if question already exists. If Yes, delete it from the array -> //EDIT PROPOSES
    $questiontags = get_tags_from_question($questionid);
    $existant_tags = [];

    foreach ($questiontags as $tag_idx => $tag) {
        if(in_array($tag['name'], $tags)){
            $key = array_search($tag['name'], $tags);
            unset($tags[$key]);
            $existant_tags[] = $tag['tagid'];
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


function top_scored_questions($page = 0) {

    global $conn;
    $limit = 4;
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