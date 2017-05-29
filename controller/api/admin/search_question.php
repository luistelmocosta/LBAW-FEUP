<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');
include_once($BASE_DIR . 'database/admin.php');
include_once($BASE_DIR . 'database/questions.php');

$question = $_GET['search'];
$search = search_questions($question);
$search_results = [];

foreach ($search as $key => $result) {
    $search_results = get_questions_from_id($result['publicationid']);
}



echo json_encode($search_results);