<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');

PagePermissions::create('auth')->check();

$userid = auth_user('userid');

$user = userProfile($userid)[0];
$avatar = $user['avatar'];
$avatarprof = $avatar;

$smarty->assign('user', $user);
$smarty->assign('avatar', $avatar);
$smarty->assign('avatarprof', $avatarprof);

$smarty->display('common/header_log.tpl');
$smarty->display('edit_profile.tpl');
$smarty->display('common/footer.tpl');