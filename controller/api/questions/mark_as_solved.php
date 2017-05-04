<?php

include_once('../../../config/init.php');
include_once ($BASE_DIR . 'database/questions.php');

PagePermissions::create('auth')->check();


if (!isset($_GET['question']) || !is_numeric($_GET['question'])) {
    echo "Invalid Params";
    exit();
}


$questions = get_questions_from_id((int) $_GET['question']);


mark_question_as_solved($_GET['question']);
echo json_encode(['status' => true]);