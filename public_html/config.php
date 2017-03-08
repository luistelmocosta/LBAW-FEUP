<?php
/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 2/21/17
 * Time: 11:09 PM
 */

include_once('/home/luiscosta/PhpstormProjects/LBAW-FEUP/lib/smarty/Smarty.class.php');


$BASE_URL = '../API/views';
$LBAW_DIR = '../..';
$smarty = new Smarty();
$smarty->template_dir = '../views/templates';
$smarty->compile_dir = '../views/templates_c';
$smarty->assign('BASE_URL', $BASE_URL);




?>