<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');
include_once($BASE_DIR . 'database/answers.php');

if($_SESSION['logged_in']) {
    $avatar = $_SESSION['user']['avatar'];
    $smarty->assign('avatar', $avatar);
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

    $search_questions_result = [];
    foreach ($search_questions as $key => $search_question) {
        $search_questions_result[$key] = get_questions_from_id($search_question['publicationid'])[0];
    }

    foreach ($search_questions_result as $key => $item) {
        $search_questions_result[$key]['creation_date'] = time_elapsed_string($item['creation_date']);
    }


    $search_answers_tmp = [];
    foreach ($search_answers as $key => $search_answer) {
        $search_answers_tmp[$key] = answer_details_from_id($search_answer['answerid'])[0];
        //$search_answers [$key]['body'] = preg_replace("/\w*?$pstext\w*/i", "<b style='color: red'>$0</b>", $search_answers[$key]['body']);

    }

    //print_r($search_answers_tmp);
    //die();

    foreach ($search_answers_tmp as $key => $search_result_answer) {
        $search_answers_tmp[$key]['creation_date'] = time_elapsed_string($search_result_answer['creation_date']);
        $search_answers_tmp [$key]['body'] = preg_replace("/\w*?$pstext\w*/i", "<b style='color: darkblue'>$0</b>", $search_result_answer['body']);
    }

    $search_result_tags = [];
    foreach ($search_tags as $key => $search_tag) {
        $search_result_tags = get_questions_from_tagid($search_tag['tid']);
        //$search_result_tags[$key]['tags'] = get_tags_from_question($search_tags[$key]['publicationid']);
    }

    //print_r($search_result_tags);
    //print_r("-------");


    foreach ($search_result_tags as $key => $search_result_tag) {
        $search_result_tags[$key]['tags'] = get_tags_from_question($search_result_tag['publicationid']);
        $search_result_tags[$key]['creation_date'] = time_elapsed_string($search_result_tag['creation_date']);
    }

    //print_r($search_result_tags);




    $_SESSION['search_res'] = $search_res;

} catch (PDOException $e) {
    dd($e->getMessage());
    $_SESSION['error_messages'][] = "Your input is incorrect";
}

function time_elapsed_string($time_ago) {
    $time_ago = strtotime($time_ago);
    $cur_time   = time();
    $time_elapsed   = $cur_time - $time_ago - 3600;
    $seconds    = $time_elapsed ;
    $minutes    = round($time_elapsed / 60 );
    $hours      = round($time_elapsed / 3600);
    $days       = round($time_elapsed / 86400 );
    $weeks      = round($time_elapsed / 604800);
    $months     = round($time_elapsed / 2600640 );
    $years      = round($time_elapsed / 31207680 );
    // Seconds
    if($seconds <= 60){
        return "just now";
    }
    //Minutes
    else if($minutes <=60){
        if($minutes==1){
            return "one minute ago";
        }
        else{
            return "$minutes minutes ago";
        }
    }
    //Hours
    else if($hours <=24){
        if($hours==1){
            return "an hour ago";
        }else{
            return "$hours hrs ago";
        }
    }
    //Days
    else if($days <= 7){
        if($days==1){
            return "yesterday";
        }else{
            return "$days days ago";
        }
    }
    //Weeks
    else if($weeks <= 4.3){
        if($weeks==1){
            return "a week ago";
        }else{
            return "$weeks weeks ago";
        }
    }
    //Months
    else if($months <=12){
        if($months==1){
            return "a month ago";
        }else{
            return "$months months ago";
        }
    }
    //Years
    else{
        if($years==1){
            return "one year ago";
        }else{
            return "$years years ago";
        }
    }
}

$smarty->assign('pstext', $pstext);
$smarty->assign('search_questions', $search_questions_result);
$smarty->assign('search_answers', $search_answers_tmp);
$smarty->assign('search_tags', $search_result_tags);

$smarty->display('questions/search_results.tpl');
$smarty->display('common/footer.tpl');