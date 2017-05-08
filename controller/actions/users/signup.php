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

/**
 * Verifies if the password and verify_password matches
 */

if(strcmp($password, $verify_password) != 0) {
    $_SESSION['error_messages'][] = 'Password do not match';
    header("Location: $BASE_URL" . 'controller/pages/users/signup.php');
}

try {
    registerUser($username, $email, $password);
} catch (PDOException $e) {

    $_SESSION['form_values'] = $_POST;
    header("Location: $BASE_URL" . 'controller/pages/users/signup.php');
}

$user = getUserByUsername($username);

$_SESSION['username'] = $username;
$_SESSION['logged_in'] = true;
$_SESSION['user'] = $user;
$_SESSION['user']['photo'] = '/images/person-flat.png';
$_SESSION['success_messages'][] = 'User registered successfully!';
header("Location: $BASE_URL" . 'controller/pages/index.php');

