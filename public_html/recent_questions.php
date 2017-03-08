<?php
include_once('config.php');
$smarty->display('../API/views/common/header.tpl');
$smarty->display('../API/views/templates/recent_questions.tpl');
$smarty->display('../API/views/common/footer.tpl');
$smarty->display('../API/views/common/log_modal.tpl');