<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');
include_once($BASE_DIR . 'database/answers.php');

if($_SESSION['logged_in']) {
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}

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


    foreach ($search_answers as $key => $search_answer) {
        $search_answers_tmp = $search_answers;
        $search_answers[$key] = answer_details_from_id($search_answer['answerid']);
        //$search_answers [$key]['body'] = preg_replace("/\w*?$pstext\w*/i", "<b style='color: red'>$0</b>", $search_answers[$key]['body']);


    }

    $search_result_tags = [];
    foreach ($search_tags as $key => $search_tag) {
        $search_result_tags = get_questions_from_tagid($search_tag['tid']);
        //$search_result_tags[$key]['tags'] = get_tags_from_question($search_tags[$key]['publicationid']);
    }

    print_r($search_result_tags);
    print_r("-------");


    foreach ($search_result_tags as $key => $search_result_tag) {
        $search_result_tags[$key]['tags'] = get_tags_from_question($search_result_tag['publicationid']);
    }

    print_r($search_result_tags);




    $_SESSION['search_res'] = $search_res;

} catch (PDOException $e) {
    dd($e->getMessage());
    $_SESSION['error_messages'][] = "Your input is incorrect";
}

$smarty->assign('pstext', $pstext);
$smarty->assign('search_questions', $search_questions);
$smarty->assign('search_answers', $search_answers[0]);
$smarty->assign('search_tags', $search_result_tags);

$smarty->display('search_results.tpl');
$smarty->display('common/footer.tpl');