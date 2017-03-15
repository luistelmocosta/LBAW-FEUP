<?php
/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 3/14/17
 * Time: 9:54 PM
 */

include_once ('../config/config.php');
$smarty->display('../common/header.tpl');
$smarty->display('top_scored_questions.tpl');
$smarty->display('../common/footer.tpl');