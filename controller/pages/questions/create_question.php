<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');

PagePermissions::create('auth')->check();

if($_SESSION['logged_in']) {
    $avatar = $_SESSION['user']['avatar'];
    $smarty->assign('avatar', $avatar);
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}

$categories = get_all_categories();
$size = sizeof($categories);
$categories_select = [];
foreach ($categories as $category) {
    $categories_select[] = $category['name'];
}

$smarty->assign('categories', $categories_select);
$smarty->display('questions/create_question.tpl');
$smarty->display('common/footer.tpl');