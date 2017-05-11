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

$result = publication_is_voted($publicationid); //is publication voted by me?
$output = $values;


//If the user did not vote yet, create a new vote
if ($result == 0) {
    create_vote($publicationid, $values);
}
//If the user already vote on that publication, wether the vote is 1 or -1, we compare the existent vote (result)
//and the new vote (output)
if ($result == 1) {
    if($values == 1) {
        delete_vote($publicationid, $values); //already voted like, pressed like -> remove like
        $output = 0;
    }
    if($values == -1) { //already voted like, voted unlike -> updates like
        update_vote($publicationid, $values);
    }
}

//Already voted dislike
if ($result == -1) {
    if($values == -1) {
        delete_vote($publicationid, $values); //votes dislike again-> deletes like
        $output = 0;
    }
    if($values == 1) {
        update_vote($publicationid, $values); //changes his unlike vote to like -> updates like
    }
}

echo json_encode(['result' => $output]); //New vote result
exit();