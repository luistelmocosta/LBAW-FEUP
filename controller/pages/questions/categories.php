<?php

include_once('../../../config/init.php');
include_once ($BASE_DIR . 'database/questions.php');

if($_SESSION['logged_in']) {
    $avatar = $_SESSION['user']['avatar'];
    $smarty->assign('avatar', $avatar);
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}

$categories = get_categories();
$size = sizeof($categories);


$smarty->assign('categories', $categories);
$smarty->display('categories/categories.tpl');
$smarty->display('common/footer.tpl');