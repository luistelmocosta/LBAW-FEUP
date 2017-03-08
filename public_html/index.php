<?php
include_once('config.php');
$smarty->display('../common/header.tpl');
$smarty->display('index.tpl');
$smarty->display('../API/views/common/footer.tpl');
$smarty->display('../API/views/common/log_modal.tpl');