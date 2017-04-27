<?php

include_once('../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');
include_once($BASE_DIR . 'database/users.php');

if($_SESSION['logged_in']) {
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/header.tpl');
}

$recent_questions = recent_questions();
$unanswered_questions = unanswered_questions();
$top_scored_questions = top_scored_questions();
$top_scored_users = top_scored_users();

$smarty->assign('top_scored_users', $top_scored_users);
$smarty->assign('recent_questions', $recent_questions);
$smarty->assign('unanswered_questions', $unanswered_questions);
$smarty->assign('top_scored_questions', $top_scored_questions);
$smarty->display('index.tpl');
$smarty->display('common/footer.tpl');
