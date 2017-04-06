<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');

PagePermissions::create('auth')->check();



$question = [
    ':userid' => auth_user('userid'),
    'body' => $_POST['editor1'],
    'title' => $_POST['title']
];

create_question($question);



if(!$_POST['title'] || !$_POST['editor1']) {
    $_SESSION['error_messages'][] = 'Title and body are required';
    $_SESSION['form_values'] = $_POST;
    back();
}

