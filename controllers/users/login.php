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