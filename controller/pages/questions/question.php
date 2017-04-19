<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');

increment_views_counter((int) $_GET['question']);

if($_SESSION['logged_in']) {
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}

$questions = get_questions_from_id($_GET['question']);
$question = $questions[0];

$smarty->assign('question', $question);
$smarty->display('question.tpl');
$smarty->display('common/footer.tpl');
