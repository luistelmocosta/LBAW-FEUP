<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');
include_once($BASE_DIR . 'database/questions.php');

PagePermissions::create('auth')->check();

$userid = auth_user('userid');
$user = userProfile($userid)[0];

$numUsers = getNumUsers()[0]['count'];
$numQuest = getNumQuestions()[0]['count'];

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
else $qpage = 0;

// Calculate the offset for the query
$uoffset = ($upage - 1)  * $limit;
$qoffset = ($qpage - 1)  * $limit;

// Display the paging information

$users = getUsersPag($uoffset, $limit);
$questions = recent_questions($qpage);

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