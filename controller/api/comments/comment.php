<?php
/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 4/24/17
 * Time: 12:21 PM
 */

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/comments.php');



$answer_comments = get_answer_comments($_GET['answerid']);


foreach ($answer_comments as $key => $answer_comment) {
    if (file_exists($BASE_DIR.'/images/users/'.$answer_comments[$key]['username'].'.png'))
        $photo_comment = '/images/users/'.$answer_comments[$key]['username'].'.png';
    if (file_exists($BASE_DIR.'/images/users/'.$answer_comments[$key]['username'].'.jpg'))
        $photo_comment = '/images/users/'.$answer_comments[$key]['username'].'.jpg';
    if (!$photo_comment) $photo_comment = '/images/person-flat.png';
    $answer_comments[$key]['user_photo'] = $photo_comment;
}

echo json_encode($answer_comments);