<?php
/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 3/8/17
 * Time: 2:13 PM
 */

include_once ('../config/config.php');
$smarty->display('../common/header_log.tpl');
$smarty->display('search_results.tpl');
$smarty->display('../common/footer.tpl');