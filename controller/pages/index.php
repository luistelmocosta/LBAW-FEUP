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

$jsonDir = $BASE_DIR . 'javascript/json/';

if (!file_exists($jsonDir))
    mkdir($jsonDir, 0777, true);

file_put_contents($jsonDir . 'siteStatsData.json', $data);

$recent_questions = recent_questions();
$unanswered_questions = unanswered_questions();
$top_scored_questions = top_scored_questions();
$top_scored_users = top_scored_users();

foreach ($top_scored_users as $key => $top_user) {
    unset($photo);
    if (file_exists($BASE_DIR.'images/users/'.$top_user['username'].'.png'))
        $photo = '/images/users/'.$top_user['username'].'.png';
    if (file_exists($BASE_DIR.'images/users/'.$top_user['username'].'.jpg'))
        $photo = '/images/users/'.$top_user['username'].'.jpg';
    if (!$photo) $photo = '/images/person-flat.png';
    $top_scored_users[$key]['photo'] = $photo;
}

$smarty->assign('tabs', $tabs);
$smarty->assign('top_scored_users', $top_scored_users);
$smarty->assign('recent_questions', $recent_questions);
$smarty->assign('unanswered_questions', $unanswered_questions);
$smarty->assign('top_scored_questions', $top_scored_questions);
$smarty->display('index.tpl');
$smarty->display('common/footer.tpl');
