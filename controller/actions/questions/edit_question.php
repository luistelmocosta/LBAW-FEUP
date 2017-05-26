<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');

PagePermissions::create('auth')->check();

validate_question_form();

$tags = explode(',', $_POST['tags']);
$tags_strimmed = array_map('trim', $tags);

foreach($tags_strimmed as $key => $tag) {
    $tags_strimmed[$key] = strtolower($tags_strimmed[$key]);
}



$category = get_categoryID_by_name($_POST['category']);

$questionid = $_POST['questionid'];


$question = [
    'questionid' => $questionid,
    'body' => $_POST['editor1'],
    'title' => $_POST['title'],
    'categoryid' => $category
];

try {

    $conn->beginTransaction();
    update_question($question);
    update_tags_edit($questionid, $tags_strimmed);


    $conn->commit();

    redirect('controller/pages/questions/question.php?question=' .  $questionid);


} catch (PDOException $e) {
    dd($e->getMessage());
    $_SESSION['error_messages'][] = "Your input is incorrect";

}


function validate_question_form()
{
    if (!$_POST['title'] || !$_POST['editor1']) {
        $_SESSION['error_messages'][] = 'Title and description are required';
        $_SESSION['form_values'] = $_POST;
        back();
    }
    if (!$_POST['tags']) {
        $_SESSION['error_messages'][] = 'You should have atleast one tag!!';
        $_SESSION['form_values'] = $_POST;
        back();
    }
    $tags = explode(',', $_POST['tags']);
    $tags_strimmed = array_map('trim', $tags);

    foreach($tags_strimmed as $key => $tag) {
        $tags_strimmed[$key] = strtolower($tags_strimmed[$key]);
    }

    foreach ($tags_strimmed as $key => $tag) {
        if (strlen($tags[$key]) > 9) {
            $_SESSION['error_messages'][] = 'Tags are not longer than 10 characters';
            $_SESSION['form_values'] = $_POST;
            back();
        }
    }
}