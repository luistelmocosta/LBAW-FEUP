<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');

PagePermissions::create('auth')->check();

$smarty->display('common/header_log.tpl');

$userid = auth_user('userid');

$user = userProfile($userid)[0];

$smarty->assign('user', $user);

$smarty->display('edit_profile.tpl');
$smarty->display('common/footer.tpl');