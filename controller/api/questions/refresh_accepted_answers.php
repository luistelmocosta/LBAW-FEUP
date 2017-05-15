<?php

include_once('../../../config/init.php');
include_once ($BASE_DIR . 'database/questions.php');
include_once ($BASE_DIR . 'database/votes.php');

PagePermissions::create('auth')->check();



if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    echo "Invalid Params (id)";
    exit();
}


$publicationid = (int)$_GET['id'];

$rating = is_answer_accepted($publicationid);

if(!$rating) {
    $rating = 0;
}



echo json_encode(['rating' => $rating]);
exit();