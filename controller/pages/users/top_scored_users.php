<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');
include_once($BASE_DIR . 'database/questions.php');

if($_SESSION['logged_in']) {
    $avatar = $_SESSION['user']['avatar'];
    $smarty->assign('avatar', $avatar);
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}

$top_scored_users = top_scored_users_page();

foreach ($top_scored_users as $key => $top_user) {
    unset($photo);
    if (file_exists($BASE_DIR.'images/users/'.$top_user['username'].'.png'))
        $photo = $BASE_URL.'images/users/'.$top_user['username'].'.png';
    if (file_exists($BASE_DIR.'images/users/'.$top_user['username'].'.jpg'))
        $photo = $BASE_URL.'images/users/'.$top_user['username'].'.jpg';
    if (!$photo) $photo = $BASE_URL.'images/person-flat.png';
    $top_scored_users[$key]['photo'] = $photo;
}

$smarty->assign('top_scored_users', $top_scored_users);
$smarty->display('top_scored_users.tpl');
$smarty->display('common/footer.tpl');