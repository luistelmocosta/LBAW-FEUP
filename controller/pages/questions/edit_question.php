<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');

PagePermissions::create('auth')->check();

if($_SESSION['logged_in']) {
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}


$categories = get_categories();
$questions = get_questions_from_id($_GET['question']);
$tags = get_tags_from_question($_GET['question']);

$question = $questions[0];

$categories_select = [];
foreach ($categories as $category) {
    $categories_select[] = $category['name'];
}

$tags_parsed = [];
foreach($tags as $tag) {
    $tags_parsed[] = $tag['name'];
}

$tags_comma = implode(',', $tags_parsed);

$smarty->assign('categories', $categories_select);
$smarty->assign('tags', $tags_comma);
$smarty->assign('question', $question);
$smarty->display('edit_question.tpl');

