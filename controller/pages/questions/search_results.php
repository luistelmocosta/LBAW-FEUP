<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');

PagePermissions::create('auth')->check();

if($_SESSION['logged_in']) {
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}

$userid = auth_user('userid');

$search_res = searchQuestions($)


$smarty->display('search_results.tpl');
$smarty->display('common/footer.tpl');