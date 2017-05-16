<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');
include_once($BASE_DIR . 'database/answers.php');
include_once($BASE_DIR . 'database/comments.php');

PagePermissions::create('auth')->check();

$comment = [
    'userid' => auth_user('userid'),
    'questionid' => intval($_POST['questionid']),
    'body' => $_POST['comment']
];


try {
    $questionid = $_POST['questionid'];
    $conn->beginTransaction();
    create_question_comment($comment);
    $conn->commit();
    redirect('controller/pages/questions/question.php?question=' . $questionid);
} catch (PDOexception $e) {
    dd($e->getMessage());
    $_SESSION['error_messages'][] = 'Question Comment creation failed!';
    $_SESSION['form_values'] = $_POST;
}

back();

function validateInput()
{
    if (!$_POST['body']) {
        $_SESSION['error_messages'][] = 'A comment body is required';
        $_SESSION['form_values'] = $_POST;
        back();
    }
}