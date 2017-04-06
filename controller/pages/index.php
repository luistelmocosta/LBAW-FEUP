
<?php

include_once('../../config/init.php');
if($LOGGED_IN) {
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}

$smarty->display('index.tpl');
$smarty->display('common/footer.tpl');
