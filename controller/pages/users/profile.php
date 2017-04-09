<?php

include_once('../../../config/init.php');

$smarty->display('common/header_log.tpl');
$smarty->display('./profile.tpl');
$smarty->display('common/footer.tpl');