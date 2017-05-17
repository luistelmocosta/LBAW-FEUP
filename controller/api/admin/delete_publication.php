<?php

include_once('../../../config/init.php');
include_once ($BASE_DIR . 'database/questions.php');

PagePermissions::create('admin')->check();

$var = $_POST['id'];

delete_question(intval($var));

echo json_encode($var);