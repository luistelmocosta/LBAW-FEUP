
<?php

include_once('../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');

if($_SESSION['logged_in']) {
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/header.tpl');
}

$questions = recent_questions();

$smarty->assign('recent_questions', $questions);
$smarty->display('index.tpl');
$smarty->display('common/footer.tpl');
