<?php
include_once('config.php');
$smarty->display('../common/header.tpl');
$smarty->display('question.tpl');
$smarty->display('../common/footer.tpl');
$smarty->display('../common/log_modal.tpl');