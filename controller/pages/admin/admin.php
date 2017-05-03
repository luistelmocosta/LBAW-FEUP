<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');
include_once($BASE_DIR . 'database/questions.php');

PagePermissions::create('auth')->check();

$userid = auth_user('userid');
$user = userProfile($userid)[0];

$users = getUsersPag();
$questions = recent_questions();

$smarty->assign('user', $user);
$smarty->assign('users', $users);
$smarty->assign('questions', $questions);

$smarty->display('common/header_log.tpl');
$smarty->display('admin.tpl');
$smarty->display('common/footer.tpl');