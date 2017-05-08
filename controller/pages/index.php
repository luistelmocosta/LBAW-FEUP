<?php

include_once('../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');
include_once($BASE_DIR . 'database/users.php');

if($_SESSION['logged_in']) {
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/header.tpl');
}

$tabs = [
    ['recent', 'Recent Questions'],
    ['unanswered', 'Unanswered Questions'],
    ['top', 'Top Scored Questions']
];

$numQuest = getNumQuestions()[0]['count'];
$numAns = getNumAnswers()[0]['count'];
$numComm = getNumComments()[0]['count'];
$numUnsolv = getNumUnsolved()[0]['count'];

$arr = [$numQuest, $numAns, $numComm, $numUnsolv];

$data = json_encode($arr);
file_put_contents($BASE_DIR . 'javascript/json/siteStatsData.json', $data);

$recent_questions = recent_questions();
$unanswered_questions = unanswered_questions();
$top_scored_questions = top_scored_questions();
$top_scored_users = top_scored_users();

$smarty->assign('tabs', $tabs);
$smarty->assign('top_scored_users', $top_scored_users);
$smarty->assign('recent_questions', $recent_questions);
$smarty->assign('unanswered_questions', $unanswered_questions);
$smarty->assign('top_scored_questions', $top_scored_questions);
$smarty->display('index.tpl');
$smarty->display('common/footer.tpl');
