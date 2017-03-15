<?php
/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 3/15/17
 * Time: 7:31 PM
 */

include_once ('../config/config.php');
$smarty->display('../common/narrow_header.tpl');
$smarty->display('questions.tpl');
$smarty->display('../common/footer.tpl');