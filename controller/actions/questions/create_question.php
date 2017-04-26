<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');

PagePermissions::create('auth')->check();

$tags = explode(',', $_POST['tags']);
$tags_strimmed = array_map('trim', $tags);


$category = get_categoryID_by_name($_POST['category']);




$question = [
    'userid' => auth_user('userid'),
    'body' => $_POST['editor1'],
    'title' => $_POST['title'],
    'categoryid' => $category
];

try {

    $conn->beginTransaction();
    $questionid = create_question($question);
    update_tags($questionid, $tags_strimmed);


    $conn->commit();

    redirect('controller/pages/questions/question.php?question=' . $questionid);


} catch (PDOException $e) {
    dd($e->getMessage());
    $_SESSION['error_messages'][] = "Your input is incorrect";

}


if(!$_POST['title'] || !$_POST['editor1']) {
    $_SESSION['error_messages'][] = 'Title and body are required';
    $_SESSION['form_values'] = $_POST;
    back();
}

