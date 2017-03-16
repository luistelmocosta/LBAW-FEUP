<?php

/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 3/16/17
 * Time: 3:05 PM
 */

include_once('../../config/config.php');
include_once($BASE_DIR . 'database/users.php');

PagePermissions::create('guest')->check();

if (!$_POST['username'] || !$_POST['password']) {


    $_SESSION['error_messages'][] ='Invalid Login';
    $_SESSION['form_values'][] = $_POST;
    header("Location: $BASE_URL" . 'views/index.php');
    exit;

}

$username = $_POST['username'];
$password = $_POST['password'];

try {
    if(!correctAuth($username, $password)) {
        $_SESSION['error_messages'][] = 'Something is wrong with your credentials';
        header("Location: $BASE_URL" . 'views/index.php');
        exit;
    }

    $user = getUserByUsername($username);

    $_SESSION['username'] = $username;
    $_SESSION['success_messages'][] = 'Login Successful!';
    $_SESSION['logged_in'] = true;
    $_SESSION['user'] = $user;

    redirect();
} catch (PDOException $e) {
    $_SESSION['error_messages'][] = 'Login Failed';
    $_SESSION['form_values'] = $_POST;
    redirect('views/index.php');
}