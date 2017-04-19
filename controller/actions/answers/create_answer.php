<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');
include_once($BASE_DIR . 'database/answers.php');

PagePermissions::create('auth')->check();

validateInput();

$answer = [
    'userid' => auth_user('userid'),
    'questionid' => intval($_POST['questionid']),
    'body' => $_POST['editor1']
];

try {
    $conn->beginTransaction();
    $questionid = createAnswer($answer);
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