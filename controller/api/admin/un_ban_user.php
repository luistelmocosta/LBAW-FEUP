<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');
include_once($BASE_DIR . 'database/admin.php');

PagePermissions::create('admin')->check();

$userid = auth_user('userid');
$user = userProfile($userid)[0];

$targid = $_POST['uid'];

unBanUser(intval($targid));

echo json_encode($targid);
