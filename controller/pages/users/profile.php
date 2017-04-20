<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');

PagePermissions::create('auth')->check();

if($_SESSION['logged_in']) {
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}

$userid = auth_user('userid');

$user = userProfile($userid)[0];


$smarty->assign('user', $user);

$smarty->display('profile.tpl');
$smarty->display('common/footer.tpl');