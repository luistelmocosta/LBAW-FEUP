<?php

include_once('../../../config/init.php');
include_once ($BASE_DIR . 'database/questions.php');
include_once ($BASE_DIR . 'database/votes.php');

$values = ['1', '-1'];
PagePermissions::create('auth')->check();

if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    echo "Invalid Params (id)";
    exit();
}

if (!isset($_GET['value']) || !in_array($_GET['value'], $values)) {
    echo "Invalid Params (values)";
    exit();
}

$publicationid = (int)$_GET['id'];
$values = $_GET['value'];

$result = publication_is_voted($publicationid);
$output = $values;

// no vote
if ($result == 0) {
    create_vote($publicationid, $values);
}
// Already vote up
if ($result == 1) {
    if($values == 1) {
        delete_vote($publicationid, $values);
        $output = 0;
    }
    if($values == -1) {
        update_vote($publicationid, $values);
    }
}
//Already vote up
if ($result == -1) {
    if($values == -1) {
        delete_vote($publicationid, $values);
        $output = 0;
    }
    if($values == 1) {
        update_vote($publicationid, $values);
    }
}

echo json_encode(['result' => $output]);
exit();

