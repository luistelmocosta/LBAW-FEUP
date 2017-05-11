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