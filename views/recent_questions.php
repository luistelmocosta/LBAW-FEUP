<?php
include_once ('../config/config.php');
$smarty->display('../common/narrow_header.tpl');
$smarty->display('recent_questions.tpl');
$smarty->display('../common/footer.tpl');