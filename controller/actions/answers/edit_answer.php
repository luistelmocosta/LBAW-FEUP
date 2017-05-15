<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');
include_once($BASE_DIR . 'database/answers.php');

PagePermissions::create('auth')->check();

$answerid = $_POST['answerid'];
$questionid = $_POST['questionid'];


$answer = [
    'answerid' => $answerid,
    'body' => $_POST['editor1']
];

try {

    update_answer($answer);

    redirect('controller/pages/questions/question.php?question=' .  $questionid);


} catch (PDOException $e) {
    dd($e->getMessage());
    $_SESSION['error_messages'][] = "Your input is incorrect";

}


if(!$_POST['editor1']) {
    $_SESSION['error_messages'][] = 'Body is required';
    $_SESSION['form_values'] = $_POST;
    back();
}