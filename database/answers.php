<?php


function createAnswer($data)
{
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM insert_into_answers(:userid, :questionid, :body)");
    $stmt->execute(array($data['userid'], $data['questionid'], $data['body']));
    return intval($data['questionid']);
}

function answer_total_comments($aid) {
    global $conn;
    $query=$conn->prepare("SELECT answer_total_comments FROM answer_total_comments(:aid)");
    $query->execute(array($aid));


    return $query->fetch();
}

function get_answer_from_id($publicationid) {
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM question_details_from_id(:publicationid)");
    $stmt->execute(['publicationid' => $publicationid]);
    $rows = $stmt->fetchAll();
    return $rows;
}

function answer_details_from_id($publicationid) {
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM answer_details_from_id(:publicationid)");
    $stmt->execute(['publicationid' => $publicationid]);
    $rows = $stmt->fetchAll();
    return $rows;

}

function update_answer($answer) {
    global $conn;
    $stmt = $conn->prepare("UPDATE publications SET body = :body WHERE publicationid = :answerid");
    $stmt->execute($answer);
}

function update_comment($comment) {
    global $conn;
    $stmt = $conn->prepare("UPDATE publications SET body = :body WHERE publicationid = :commentid");
    $stmt->execute($comment);
}