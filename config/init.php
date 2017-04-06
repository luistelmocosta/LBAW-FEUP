<?php
/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 3/23/17
 * Time: 8:35 AM
 */

//This file is included in every .php file


session_set_cookie_params(3600, '/~lbaw1641/proto/');
session_start();


$BASE_DIR = '/home/luiscosta/PhpstormProjects/LBAW-FEUP/';
$BASE_URL = '/';

//Connect to the database

try {
    $dbuser = 'luiscosta';
    $dbpass = '123';
    $host = 'localhost';
    $dbname = 'lbaw';
    $conn = new PDO("pgsql:host=$host;dbname=$dbname", $dbuser, $dbpass);
}catch (PDOException $e) {
    echo "Error : " . $e->getMessage() . "<br/>";
    die();
}

$conn->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
$conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);


// Set the schema for this connection.
$conn->exec('SET SCHEMA \'public\'');


// Include Smarty library.
include_once($BASE_DIR	.	'lib/smarty/Smarty.class.php');

$smarty	=	new	Smarty;
$smarty->setTemplateDir($BASE_DIR	.	'view/templates/');
$smarty->setCompileDir($BASE_DIR	.	'view/templates_c/');


// Send some common variables to Smarty.
$smarty->assign('BASE_URL',	$BASE_URL);
// Send success/error messages to Smarty and delete them.
$smarty->assign('ERROR_MESSAGES',	$_SESSION['error_messages']);
$smarty->assign('FIELD_ERRORS',	$_SESSION['field_errors']);
$smarty->assign('SUCCESS_MESSAGES',	$_SESSION['success_messages']);
$smarty->assign('FORM_VALUES',	$_SESSION['form_values']);
$smarty->assign('USERNAME',	$_SESSION['username']);