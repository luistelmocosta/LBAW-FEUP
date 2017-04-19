<?php

include_once('../../config/init.php');

$questions = call_user_func();

echo json_decode($questions);