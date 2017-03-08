<?php
/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 3/8/17
 * Time: 3:15 PM
 */

include_once ('../config/config.php');
$smarty->display('../common/header_log.tpl');
$smarty->display('top_scored_users.tpl');
$smarty->display('../common/footer.tpl');