<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/admin.php');
include_once($BASE_DIR . 'database/users.php');
include_once($BASE_DIR . 'database/questions.php');

if($_SESSION['permission'] != 'admin')
    redirect();

$userid = auth_user('userid');
$user = userProfile($userid)[0];

$numUsers = getNumUsers()[0]['count'];
$numQuest = getNumQuestions()[0]['count'];


//PAGINATION

// How many info will be displayed per table
$limit = 4;

// How many pages will there be
$upages = ceil($numUsers / $limit);
$qpages = ceil($numQuest / $limit);

// What page are we currently on?
if(isset($_GET['upage']) && ($_GET['upage'] > 0 && $_GET['upage'] < ($upages + 1)))
    $upage = $_GET['upage'];
else $upage = 1;

if(isset($_GET['qpage']) && ($_GET['qpage'] > 0 && $_GET['qpage'] < ($qpages + 1)))
    $qpage = $_GET['qpage'];
else $qpage = 1;

// Calculate the offset for the query
$uoffset = ($upage - 1)  * $limit;
$qoffset = ($qpage - 1)  * $limit;

// Get data
$users = getUsersPag($uoffset, $limit);
$questions = getQuestionsPag($qoffset, $limit);


//STATS

$jsonDir = $BASE_DIR . 'javascript/json/';

if (!file_exists($jsonDir))
    mkdir($jsonDir, 0777, true);


//Site Stats

$numAns = getNumAnswers()[0]['count'];
$numComm = getNumComments()[0]['count'];
$numUnsolv = getNumUnsolved()[0]['count'];

$SSArr = [$numQuest, $numAns, $numComm, $numUnsolv];

$SSdata = json_encode($SSArr);
file_put_contents($jsonDir . 'siteStatsData.json', $SSdata);

//User Stats

$numEdit = getNumModerators()[0]['count'];
$numAdmins = getNumAdmins()[0]['count'];

$USArr = [$numUsers, $numEdit, $numAdmins];

$USdata = json_encode($USArr);
file_put_contents($jsonDir . 'userStatsData.json', $USdata);

//Behaviour Stats

$numModReg = getNumModReg()[0]['count'];
$numBans = getNumBans()[0]['count'];
$numWarns = $numModReg - $numBans;

$BSArr = [$numModReg, $numWarns, $numBans];

$BSdata = json_encode($BSArr);
file_put_contents($jsonDir . 'behaviourStatsData.json', $BSdata);


//SMARTY

$smarty->assign('user', $user);
$smarty->assign('users', $users);
$smarty->assign('questions', $questions);

$smarty->assign('upage', $upage);
$smarty->assign('upages', $upages);

$smarty->assign('qpage', $upage);
$smarty->assign('qpage', $upage);


$smarty->display('common/header_log.tpl');
$smarty->display('admin.tpl');
$smarty->display('common/footer.tpl');