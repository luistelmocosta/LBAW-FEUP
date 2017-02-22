<?php
/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 2/21/17
 * Time: 11:09 PM
 */

include_once('../lib/smarty/Smarty.class.php');


$BASE_URL = '/';
$LBAW_DIR = '../';
$smarty = new Smarty();
$smarty->template_dir = '../templates';
$smarty->compile_dir = '../templates_c';
$smarty->assign('BASE_URL', $BASE_URL);




?>