<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');
include_once($BASE_DIR . 'database/questions.php');

PagePermissions::create('auth')->check();

$permission = $_SESSION['permission'];


if(isset($_GET['userid'])) {
    $userid = $_GET['userid'];
}
else {
    $userid = auth_user('userid');
    $own = true;
}

$avatar = $_SESSION['user']['avatar'];

$user = userProfile($userid)[0];
$avatarprof = $user['avatar'];

if($_SESSION['logged_in']) {

    $smarty->assign('avatar', $avatar);
    $smarty->assign('avatarprof', $avatarprof);

    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}

$user_questions = get_questions_by_user_id($userid);
$user_mod_regs_bans =  get_mod_reg_ban_by_user_id($userid);
$user_mod_regs_warns = get_mod_reg_warn_by_user_id($userid);

$smarty->assign('user', $user);
$smarty->assign('user_questions', $user_questions);
$smarty->assign('user_mod_regs_bans', $user_mod_regs_bans);
$smarty->assign('user_mod_regs_warns', $user_mod_regs_warns);

$smarty->assign('permission', $permission);
$smarty->assign('own', $own);

$smarty->display('profile.tpl');
$smarty->display('common/footer.tpl');