<?php


function create_comment($data)
{
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM insert_into_answercomments(:userid, :answerid, :body)");
    $stmt->execute(array($data['userid'], $data['answerid'], $data['body']));
    return intval($data['answerid']);
}

function get_answer_comments($answerid){


    global $conn;

    $query=$conn->prepare("SELECT * FROM get_answer_comments(:answerid)");
    $query->execute(['answerid' => $answerid]);

    return $query->fetchAll();

}