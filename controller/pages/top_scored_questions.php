<?php
include_once('../config/config.php');
$smarty->display('../common/narrow_header.tpl');
$smarty->display('top_scored_questions.tpl');
$smarty->display('../common/footer.tpl');