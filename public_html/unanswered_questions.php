<?php
/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 3/7/17
 * Time: 9:10 PM
 */

include_once('config.php');
$smarty->display('../common/header.tpl');
$smarty->display('unanswered_questions.tpl');
$smarty->display('../common/footer.tpl');