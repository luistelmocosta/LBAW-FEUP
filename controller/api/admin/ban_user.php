<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');
include_once($BASE_DIR . 'database/admin.php');

$userid = auth_user('userid');
$user = userProfile($userid)[0];

$targid = intval($_POST['uid']);

$reason = "";

banUser($userid, $targid, $reason);

echo json_encode($targid);
