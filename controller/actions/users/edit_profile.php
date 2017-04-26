<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');

PagePermissions::create('auth')->check();

$userid = auth_user('userid');
$fullname = $_POST['fullname'];
$email = $_POST['email'];
$location = $_POST['location'];
$about = $_POST['about'];

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

/*if(!$_POST['title'] || !$_POST['editor1']) {
    $_SESSION['error_messages'][] = 'Title and body are required';
    $_SESSION['form_values'] = $_POST;
    back();
}*/