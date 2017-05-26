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

if(!$_FILES['file'])
    $avatar = $user['avatar'];
else {
    $photo = $_FILES['file'];
    $extension = end(explode(".", $photo["name"]));
    $avatar = $BASE_URL . "images/users/" . $user['username'] . '.' . $extension;
    move_uploaded_file($photo["tmp_name"], $BASE_DIR . "images/users/" . $user['username'] . '.' . $extension); // this is dangerous
}

$update_user = [
    'userid' => $userid,
    'fullname' => $fullname,
    'email' => $email,
    'location' => $location,
    'about' => $about,
    'avatar' => $avatar
];

if(check_location($location) == null)
    create_location($location);

try {
    update_user_profile($update_user);

    redirect('controller/pages/users/profile.php');

} catch (PDOException $e) {
    dd($e->getMessage());
    $_SESSION['error_messages'][] = "Your input is incorrect";
}