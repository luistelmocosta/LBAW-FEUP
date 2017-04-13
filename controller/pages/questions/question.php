<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');




$smarty->display('../common/narrow_header.tpl');
$smarty->display('question.tpl');
$smarty->display('../common/footer.tpl');

