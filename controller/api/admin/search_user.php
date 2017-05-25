<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');
include_once($BASE_DIR . 'database/admin.php');

$search = $_GET['search'];

$search_results = search_users($search);

echo json_encode($search_results[0]);