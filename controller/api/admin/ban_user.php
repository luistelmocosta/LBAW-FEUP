<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');
include_once($BASE_DIR . 'database/admin.php');

$userid = auth_user('userid');
$user = userProfile($userid)[0];

$reason = $_POST['reasonMsg'];
$targid = intval($_POST['uid']);
$banSpan = $_POST['banSpan'];

if(!$banSpan) {
    $_SESSION['error_messages'] = "Invalid date";
}

//$enddate = date('d-m-Y h:i:s a', strtotime("+" . $banSpan . " days"));
$enddate = date('Y-m-d', strtotime($banSpan));


banUser($userid, $targid, $reason, $enddate);