<?php

include_once('../../config/init.php');

if($_SESSION['logged_in']) {
    $avatar = $_SESSION['user']['avatar'];
    $smarty->assign('avatar', $avatar);
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}

$smarty->display('about.tpl');
$smarty->display('common/footer.tpl');