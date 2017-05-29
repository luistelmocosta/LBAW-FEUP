<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');

PagePermissions::create('auth')->check();

$userid = auth_user('userid');

$user = userProfile($userid)[0];
$avatar = $user['avatar'];
$avatarprof = $avatar;
$badges = userBadges($userid);

foreach ($badges as $key => $badge) {

    if (file_exists($BASE_DIR.'/images/badges/'.$badge['name'].'.png'))
        $badge_picture = '/images/badges/'.$badge['name'].'.png';
    if (file_exists($BASE_DIR.'/images/users/'.$badge['name'].'.jpg'))
        $badge_picture = '/images/users/'.$badge['name'].'.jpg';
}

$smarty->assign('user', $user);
$smarty->assign('avatar', $avatar);
$smarty->assign('avatarprof', $avatarprof);
$smarty->assign('badges', $badges);


$smarty->display('common/header_log.tpl');
$smarty->display('users/edit_profile.tpl');
$smarty->display('common/footer.tpl');