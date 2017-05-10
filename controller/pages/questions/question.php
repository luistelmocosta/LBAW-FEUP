<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');
include_once($BASE_DIR . 'database/votes.php');
include_once($BASE_DIR . 'database/users.php');

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

}



$smarty->assign('isMine', $question['isMine']);
$smarty->assign('tags', $tags);
$smarty->assign('photo', $photo);
$smarty->assign('answers', $answers);
$smarty->assign('question', $question);
$smarty->display('question.tpl');
$smarty->display('common/footer.tpl');
