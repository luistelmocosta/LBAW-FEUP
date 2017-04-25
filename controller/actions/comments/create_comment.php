<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');
include_once($BASE_DIR . 'database/answers.php');
include_once($BASE_DIR . 'database/comments.php');

PagePermissions::create('auth')->check();

$comment = [
    'userid' => auth_user('userid'),
    'answerid' => intval($_POST['answerid']),
    'body' => $_POST['comment']
];


try {
    $questionid = $_POST['questionid'];
    $conn->beginTransaction();
    create_comment($comment);
    $conn->commit();
    redirect('controller/pages/questions/question.php?question=' . $questionid);
} catch (PDOexception $e) {
    dd($e->getMessage());
    $_SESSION['error_messages'][] = 'Answer creation failed.';
    $_SESSION['form_values'] = $_POST;
}

back();

function validateInput()
{
    if (!$_POST['body']) {
        $_SESSION['error_messages'][] = 'A answers body is required';
        $_SESSION['form_values'] = $_POST;
        back();
    }
}