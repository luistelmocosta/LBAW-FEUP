<?php


function create_comment($data)
{
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM insert_into_answercomments(:userid, :answerid, :body)");
    $stmt->execute(array($data['userid'], $data['answerid'], $data['body']));
    return intval($data['answerid']);
}

function create_question_comment($data)
{
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM insert_into_questioncomments(:userid, :questionid, :body)");
    $stmt->execute(array($data['userid'], $data['questionid'], $data['body']));
    return intval($data['questionid']);
}

function get_answer_comments($answerid){


    global $conn;

    $query=$conn->prepare("SELECT * FROM get_answer_comments(:answerid)");
    $query->execute(['answerid' => $answerid]);

    return $query->fetchAll();

}

function get_question_comments($questionid){


    global $conn;

    $query=$conn->prepare("SELECT * FROM get_question_comments(:questionid)");
    $query->execute(['questionid' => $questionid]);

    return $query->fetchAll();

}