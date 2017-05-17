<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');

PagePermissions::create('auth')->check();

if($_SESSION['logged_in']) {
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}

$categories = get_categories();
$size = sizeof($categories);
$categories_select = [];
foreach ($categories as $category) {
    $categories_select[] = $category['name'];
}

$smarty->assign('categories', $categories_select);
$smarty->display('create_question.tpl');
$smarty->display('common/footer.tpl');