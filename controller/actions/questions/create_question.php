<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');

PagePermissions::create('auth')->check();

$tags = explode(',', $_POST['tags']);
print_r($myArray);
die();

$category = get_categoryID_by_name($_POST['category']);

$question = [
    'userid' => auth_user('userid'),
    'body' => $_POST['editor1'],
    'title' => $_POST['title'],
    'categoryid' => $category
];

create_question($question, $tags);

if(!$_POST['title'] || !$_POST['editor1']) {
    $_SESSION['error_messages'][] = 'Title and body are required';
    $_SESSION['form_values'] = $_POST;
    back();
}

