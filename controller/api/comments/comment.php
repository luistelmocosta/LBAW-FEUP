<?php
/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 4/24/17
 * Time: 12:21 PM
 */

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/comments.php');
include_once($BASE_DIR . 'database/users.php');
include_once($BASE_DIR . 'database/questions.php');

PagePermissions::create('auth')->check();

$type = $_GET['type'];

$userid = auth_user('userid');
$user_profile = userProfile($userid);
$user = $user_profile[0];


if($type == "question") {
    $question_comments = get_question_comments($_GET['questionid']);

    foreach ($question_comments as $key => $question_comment) {
        if (file_exists($BASE_DIR.'images/users/'.$question_comments[$key]['username'].'.png'))
            $photo_comment = $BASE_URL.'images/users/'.$question_comments[$key]['username'].'.png';
        if (file_exists($BASE_DIR.'images/users/'.$question_comments[$key]['username'].'.jpg'))
            $photo_comment = $BASE_URL.'images/users/'.$question_comments[$key]['username'].'.jpg';
        if (!$photo_comment) $photo_comment = $BASE_URL.'images/person-flat.png';
        $question_comments[$key]['user_photo'] = $photo_comment;
        $question_comments[$key]['user_ranking'] = $user['count_votes_rating_received'];
        $question_comments[$key]['creation_date'] = time_elapsed_string($question_comments[$key]['creation_date']);
        $qis = question_is_mine($question_comments[$key]);
        $question_comments[$key]['IsMine'] = $qis;
    }

    echo json_encode($question_comments);

} else {
    $answer_comments = get_answer_comments($_GET['answerid']);

    foreach ($answer_comments as $key => $answer_comment) {
        if (file_exists($BASE_DIR.'images/users/'.$answer_comments[$key]['username'].'.png'))
            $photo_comment = $BASE_URL.'images/users/'.$answer_comments[$key]['username'].'.png';
        if (file_exists($BASE_DIR.'images/users/'.$answer_comments[$key]['username'].'.jpg'))
            $photo_comment = $BASE_URL.'images/users/'.$answer_comments[$key]['username'].'.jpg';
        if (!$photo_comment) $photo_comment = $BASE_URL.'images/person-flat.png';
        $answer_comments[$key]['user_photo'] = $photo_comment;
        $answer_comments[$key]['user_ranking'] = $user['count_votes_rating_received'];
        $answer_comments[$key]['creation_date'] = time_elapsed_string($answer_comments[$key]['creation_date']);
    }

    echo json_encode($answer_comments);



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

