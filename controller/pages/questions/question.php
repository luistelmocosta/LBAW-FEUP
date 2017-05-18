<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');
include_once($BASE_DIR . 'database/votes.php');
include_once($BASE_DIR . 'database/users.php');
include_once($BASE_DIR . 'database/answers.php');

increment_views_counter((int) $_GET['question']);

if($_SESSION['logged_in']) {
    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}

$questions = get_questions_from_id($_GET['question']);
$tags = get_tags_from_question($_GET['question']);
$question = $questions[0];
$question['voted'] = publication_is_voted($_GET['question']);
$question['isMine'] = question_is_mine($question);
$answers = get_answers_from_questionid($_GET['question']);
$user = userProfile($question['userid']);
$question['creation_date'] = time_elapsed_string($question['creation_date']);
$category = get_question_categoryid($_GET['question']);
$categoryid = (int)$category['categoryid'];
$related_questions = related_questions($categoryid, $_GET['question']);

foreach ($related_questions as $key => $related_question) {
    if (file_exists($BASE_DIR.'/images/users/'.$related_questions[$key]['username'].'.png'))
        $photo_related_question = '/images/users/'.$related_questions[$key]['username'].'.png';
    if (file_exists($BASE_DIR.'/images/users/'.$related_questions[$key]['username'].'.jpg'))
        $photo_related_question = '/images/users/'.$related_questions[$key]['username'].'.jpg';
    if (!$photo_related_question) $photo_related_question = '/images/person-flat.png';

    $related_questions[$key]['creation_date'] = time_elapsed_string($related_questions[$key]['creation_date']);
    $related_questions[$key]['user_photo'] = $photo_related_question;
}

unset($photo);
if (file_exists($BASE_DIR.'images/users/'.$question['username'].'.png'))
    $photo = '/images/users/'.$question['username'].'.png';
if (file_exists($BASE_DIR.'images/users/'.$question['username'].'.jpg'))
    $photo = '/images/users/'.$question['username'].'.jpg';
if (!$photo) $photo = '/images/person-flat.png';

foreach ($answers as $key => $answer) {
    $answers_comment = [];
    if (file_exists($BASE_DIR.'/images/users/'.$answers[$key]['username'].'.png'))
        $photo_answer = '/images/users/'.$answers[$key]['username'].'.png';
    if (file_exists($BASE_DIR.'/images/users/'.$answers[$key]['username'].'.jpg'))
        $photo_answer = '/images/users/'.$answers[$key]['username'].'.jpg';
    if (!$photo_answer) $photo_answer = '/images/person-flat.png';
    $answer_user = userProfile($answers[$key]['userid']);
    $answer_score = answer_score($answers[$key]['answerid']);
    $answers[$key]['voted'] = publication_is_voted($answers[$key]['answerid']);
    $answers[$key]['upvotes'] = $answer_score['answer_ranking'];
    $answers[$key]['isMine'] = question_is_mine($answers[$key]['answerid']);
    $answers[$key]['user_photo'] = $photo_answer;
    $answers[$key]['answer_user_points'] = $answer_user[0]['count_votes_rating_received'];
    $answers[$key]['role'] = $answer_user[0]['role'];
    $answers[$key]['total_comments'] = answer_total_comments($answers[$key]['answerid'])['answer_total_comments'];
    $answers[$key]['creation_date'] = time_elapsed_string($answers[$key]['creation_date']);


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





$smarty->assign('isMine', $question['isMine']);
$smarty->assign('tags', $tags);
$smarty->assign('photo', $photo);
$smarty->assign('answers', $answers);
$smarty->assign('question', $question);
$smarty->assign('related_questions', $related_questions);
$smarty->assign('category', $categoryid);
$smarty->display('question.tpl');
$smarty->display('common/footer.tpl');
