<?php

include_once('../../../config/init.php');
include_once ($BASE_DIR . 'database/questions.php');

if($_SESSION['logged_in']) {
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}

$cid = $_GET['category'];

$questions=category_questions($cid);

$smarty->assign('category_questions', $questions);
$smarty->display('category_questions.tpl');
$smarty->display('common/footer.tpl');