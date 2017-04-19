<?php


function createAnswer($data)
{
    
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM insert_into_answers(:userid, :questionid, :body)");
    $stmt->execute(array($data['userid'], $data['questionid'], $data['body']));
    return intval($data['questionid']);
}