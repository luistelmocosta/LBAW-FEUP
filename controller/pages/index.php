<?php

include_once('../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');
include_once($BASE_DIR . 'database/users.php');

$tabs = [
    ['recent', 'Recent Questions'],
    ['unanswered', 'Unanswered Questions'],
    ['top', 'Top Scored Questions']
];

$numQuest = getNumQuestions()[0]['count'];
$numAns = getNumAnswers()[0]['count'];
$numComm = getNumComments()[0]['count'];
$numUnsolv = getNumUnsolved()[0]['count'];

$arr = [$numQuest, $numAns, $numComm, $numUnsolv];

$data = json_encode($arr);

$jsonDir = $BASE_DIR . 'javascript/json/';

if (!file_exists($jsonDir))
    mkdir($jsonDir, 0777, true);

file_put_contents($jsonDir . 'siteStatsData.json', $data);

$recent_questions = recent_questions();

foreach ($recent_questions as $key => $recent_question) {
    $recent_questions[$key]['creation_date'] = time_elapsed_string($recent_questions[$key]['creation_date']);
}

$unanswered_questions = unanswered_questions();

foreach ($unanswered_questions as $key => $unanswered_question) {
    $unanswered_questions[$key]['creation_date'] = time_elapsed_string($unanswered_questions[$key]['creation_date']);
}

$top_scored_questions = top();

foreach ($top_scored_questions as $key => $top_scored_question) {
    $top_scored_questions[$key]['creation_date'] = time_elapsed_string($top_scored_questions[$key]['creation_date']);
}

$top_scored_users = top_scored_users();

foreach ($top_scored_users as $key => $top_user) {
    unset($photo);
    if (file_exists($BASE_DIR.'images/users/'.$top_user['username'].'.png'))
        $photo = $BASE_URL.'images/users/'.$top_user['username'].'.png';
    if (file_exists($BASE_DIR.'images/users/'.$top_user['username'].'.jpg'))
        $photo = $BASE_URL.'images/users/'.$top_user['username'].'.jpg';
    if (!$photo) $photo = $BASE_URL.'images/person-flat.png';
    $top_scored_users[$key]['photo'] = $photo;
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

if($_SESSION['logged_in']) {
    $avatar = $_SESSION['user']['avatar'];
    $smarty->assign('avatar', $avatar);
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}

$smarty->assign('tabs', $tabs);
$smarty->assign('top_scored_users', $top_scored_users);
$smarty->assign('recent_questions', $recent_questions);
$smarty->assign('unanswered_questions', $unanswered_questions);
$smarty->assign('top_scored_questions', $top_scored_questions);
$smarty->assign('avatar', $avatar);

$smarty->display('index.tpl');
$smarty->display('common/footer.tpl');
