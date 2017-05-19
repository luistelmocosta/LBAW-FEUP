<?php

include_once('../../../config/init.php');
include_once ($BASE_DIR . 'database/questions.php');

if($_SESSION['logged_in']) {
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}

$categoryid = $_GET['category'];
$questions = category_questions($categoryid);
$category = $questions[0]['name'];


$smarty->assign('category_questions', $questions);
$smarty->assign('category', $category);
$smarty->display('category_questions.tpl');
$smarty->display('common/footer.tpl');
