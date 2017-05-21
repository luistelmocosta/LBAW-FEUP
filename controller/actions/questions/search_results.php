<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');

if(!$_POST['psearch']) {
    $_SESSION['error_messages'][] = 'Search text required';
    $_SESSION['form_values'] = $_POST;
    back();
}
else $pstext = $_POST['psearch'];

$_SESSION['pstext'] = $pstext;

$search_questions = [];
$search_answers = [];
$search_tags = [];

try {
    $search_trimmed = preg_replace('/\s+/', '', $pstext);
    $search_questions = search_questions($pstext);
    $search_answers = search_answers($pstext);
    $search_tags = search_tags($pstext);

    $_SESSION['search_res'] = $search_res;

} catch (PDOException $e) {
    dd($e->getMessage());
    $_SESSION['error_messages'][] = "Your input is incorrect";
}



$smarty->assign('pstext', $pstext);
$smarty->assign('search_questions', $search_questions);
$smarty->assign('search_answers', $search_answers);
$smarty->assign('search_tags', $search_tags);

$smarty->display('search_results.tpl');
$smarty->display('common/footer.tpl');