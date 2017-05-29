<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');

PagePermissions::create('auth')->check();

$userid = auth_user('userid');

if(!$_POST['oldpassword'] || !$_POST['newpassword1'] || !$_POST['newpassword2']) {
    $_SESSION['error_messages'][] = 'Some of the fields are missing';
    $_SESSION['form_values'][] = $_POST;
    header("Location: $BASE_URL" . 'controller/pages/users/edit_profile.php');
    exit;
}

$oldpwd = $_POST['oldpassword'];
$newpwd1 = $_POST['newpassword1'];
$newpwd2 = $_POST['newpassword2'];

$username = getUserNameByUserID($userid)[0]['username'];

if(!correctAuth($username, $oldpwd)){
    $_SESSION['error_messages'][] = 'Old password does not match';
    header("Location: $BASE_URL" . 'controller/pages/users/edit_profile.php');
    exit;
}

if($newpwd1 != $newpwd2){
    $_SESSION['error_messages'][] = 'New passwords does not match';
    header("Location: $BASE_URL" . 'controller/pages/users/edit_profile.php');
    exit;
}

changeUserPwd($username, $newpwd1);
header("Location: $BASE_URL" . 'controller/pages/users/edit_profile.php');
