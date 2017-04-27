<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');


if($_SESSION['logged_in']) {
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}

$userid = auth_user('userid');

$pstext = $_SESSION['pstext'];
$search_res = $_SESSION['search_res'];

$smarty->assign('pstext', $pstext);
$smarty->assign('search_res', $search_res);

$smarty->display('search_results.tpl');
$smarty->display('common/footer.tpl');