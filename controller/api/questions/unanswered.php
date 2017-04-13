<?php

include_once('../../../config/init.php');

$smarty->display('common/narrow_header.tpl');
$smarty->display('unanswered_questions.tpl');
$smarty->display('common/footer.tpl');