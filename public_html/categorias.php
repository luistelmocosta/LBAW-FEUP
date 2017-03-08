<?php
/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 3/7/17
 * Time: 9:16 PM
 */

include_once('config.php');
$smarty->display('../common/header.tpl');
$smarty->display('categorias.tpl');
$smarty->display('../common/footer.tpl');
