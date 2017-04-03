<?php
include_once('../config/config.php');
$smarty->display('../common/header.tpl');
$smarty->display('unanswered_questions.tpl');
$smarty->display('../common/footer.tpl');