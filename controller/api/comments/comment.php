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

echo json_encode($answer_comments);