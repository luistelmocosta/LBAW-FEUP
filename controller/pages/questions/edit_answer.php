<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');
include_once($BASE_DIR . 'database/answers.php');

PagePermissions::create('auth')->check();

if($_SESSION['logged_in']) {
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}



$answer = answer_details_from_id($_GET['answer']);


$answer_info = $answer[0];



$smarty->assign('answer', $answer_info);
$smarty->display('answers_partials/edit_answer.tpl');

