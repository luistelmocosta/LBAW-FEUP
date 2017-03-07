<?php
include_once ('../config/config.php');
$smarty->display('../common/header.tpl');
$smarty->display('admin.tpl');
$smarty->display('../common/footer.tpl');
$smarty->display('../common/log_modal.tpl');
