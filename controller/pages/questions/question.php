<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');
include_once($BASE_DIR . 'database/votes.php');

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


    unset($photo);
    if (file_exists($BASE_DIR.'images/users/'.$question['username'].'.png'))
        $photo = '/images/users/'.$question['username'].'.png';
    if (file_exists($BASE_DIR.'images/users/'.$question['username'].'.jpg'))
        $photo = '/images/users/'.$question['username'].'.jpg';
    if (!$photo) $photo = '/images/person-flat.png';



$smarty->assign('isMine', $question['isMine']);
$smarty->assign('tags', $tags);
$smarty->assign('photo', $photo);
$smarty->assign('answers', $answers);
$smarty->assign('question', $question);
$smarty->display('question.tpl');
$smarty->display('common/footer.tpl');
