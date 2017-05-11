<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');
include_once($BASE_DIR . 'database/questions.php');

PagePermissions::create('auth')->check();

if($_SESSION['logged_in']) {
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}


if(isset($_GET['userid']))
    $userid = $_GET['userid'];
else $userid = auth_user('userid');

$user = userProfile($userid)[0];

$user_questions = get_questions_by_user_id($userid);

$smarty->assign('user', $user);
$smarty->assign('user_questions', $user_questions);
$smarty->assign('photo', $photo);
$smarty->display('profile.tpl');
$smarty->display('common/footer.tpl');