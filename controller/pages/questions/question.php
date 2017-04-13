<?php

include_once('../../../config/init.php');

if($_SESSION['logged_in']) {
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}
$smarty->display('question.tpl');
$smarty->display('common/footer.tpl');
