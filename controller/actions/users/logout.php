<?php

include_once('../../../config/init.php');
session_unset();
session_destroy();

print_r($_SESSION);
die();

header("Location: $BASE_URL" . 'controller/pages/index.php');
