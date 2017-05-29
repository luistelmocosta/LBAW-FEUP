<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');
include_once($BASE_DIR . 'database/admin.php');

$userid = $_GET['search'];
$search = search_users($userid);
$search_results = [];

foreach ($search as $key => $result) {
    $search_results = userProfile($result['userid']);
}



echo json_encode($search_results);