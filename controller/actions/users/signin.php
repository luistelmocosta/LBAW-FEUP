<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');

/**
 * Verifies if username or password is empty. If so, redirects to the login page
 */

$username = $_POST['username'];
$password = $_POST['password'];


if(!$_POST['username'] || !$_POST['password']) {
    $_SESSION['error_messages'][] = 'Some of the fields are missing';
    $_SESSION['form_values'][] = $_POST;
    header("Location: $BASE_URL" . 'controller/pages/users/signin.php');
    exit;
}



try {
    if(!correctAuth($username, $password)) {
        $_SESSION['error_messages'][] = 'Error with your credentials';
        header("Location: $BASE_URL" . 'controller/pages/users/signin.php');
        exit;
    }
    $user = getUserByUsername($username);

    if(check_ban($user['userid'])[0]['count'] > 0)
        redirect('controller/pages/about.php');
    else {
      
        $_SESSION['username'] = $username;
        $_SESSION['logged_in'] = true;
        $_SESSION['user'] = $user;
        $_SESSION['success_messages'][] = 'Login Successful!';

        redirect();
    }

} catch (PDOException $e) {

    redirect('controller/pages/users/signin.php');
}







