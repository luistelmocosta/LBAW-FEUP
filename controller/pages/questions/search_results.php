<?php
include_once('../config/config.php');
$smarty->display('../common/narrow_header.tpl');
$smarty->display('search_results.tpl');
$smarty->display('../common/footer.tpl');