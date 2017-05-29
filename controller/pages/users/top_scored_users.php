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

    $photo = $top_scored_users[$key]['avatar'];
    $top_scored_users[$key]['photo'] = $photo;

}

$smarty->assign('top_scored_users', $top_scored_users);
$smarty->display('top_scored_users.tpl');
$smarty->display('common/footer.tpl');