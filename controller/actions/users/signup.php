<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');

/**
 * Verifies if username or password is empty. If so, redirects to the register page
 */

if(!$_POST['username'] || !$_POST['password']) {
    $_SESSION['error_messages'][] = 'Some of the fields are missing';
    $_SESSION['form_values'][] = $_POST;
    header("Location: $BASE_URL" . 'controller/pages/users/signup.php');
    exit;
}




$username = strip_tags($_POST['username']);
$email = strip_tags($_POST['email']);
$password = $_POST['password'];
$verify_password = $_POST['verify_password'];

$already_exists_username = getUserByUsername($username);
$already_exists_email = getUserByEmail($email);

if($already_exists_username) {
    $_SESSION['error_messages'][] = 'Username already in use';
    header("Location: $BASE_URL" . 'controller/pages/users/signup.php');
    exit;

}

if($already_exists_email) {
    $_SESSION['error_messages'][] = 'An account with that email already exists!';
    header("Location: $BASE_URL" . 'controller/pages/users/signup.php');
    exit;

}

/**
 * Verifies if the password and verify_password matches
 */

if(strcmp($password, $verify_password) != 0) {
    $_SESSION['error_messages'][] = 'Password do not match';
    header("Location: $BASE_URL" . 'controller/pages/users/signup.php');
    exit;
}

try {
    $default_avatar = $BASE_URL.'images/person-flat.png';
    registerUser($username, $email, $password, $default_avatar);
} catch (PDOException $e) {

    $_SESSION['form_values'] = $_POST;
    header("Location: $BASE_URL" . 'controller/pages/users/signup.php');
}

$user = getUserByUsername($username);

$_SESSION['username'] = $username;
$_SESSION['logged_in'] = true;
$_SESSION['user'] = $user;
$_SESSION['success_messages'][] = 'User registered successfully!';
header("Location: $BASE_URL" . 'controller/pages/index.php');

