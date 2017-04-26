<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');

PagePermissions::create('auth')->check();

$userid = auth_user('userid');
$user = userProfile($userid)[0];

if(!$_POST['fullname'])
    $fullname = $user['fullname'];
else $fullname = $_POST['fullname'];

if(!$_POST['email'])
    $email = $user['email'];
else $email = $_POST['email'];

if(!$_POST['location'])
    $location = $user['location'];
else $location = $_POST['location'];

if(!$_POST['about'])
    $about = $user['about'];
else $about = $_POST['about'];

$update_user = [
    'userid' => $userid,
    'fullname' => $fullname,
    'email' => $email,
    'location' => $location,
    'about' => $about
];

try {
    $conn->beginTransaction();
    update_user_profile($update_user);

    $conn->commit();

    redirect('controller/pages/users/profile.php');

} catch (PDOException $e) {
    dd($e->getMessage());
    $_SESSION['error_messages'][] = "Your input is incorrect";
}