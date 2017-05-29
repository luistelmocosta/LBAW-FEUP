<?php

//This file is included in every .php file
session_start();

error_reporting(E_ERROR | E_WARNING);


$BASE_DIR = '/opt/lbaw/lbaw1641/public_html/final/';
$BASE_URL = '/~lbaw1641/final/';

//Connect to the database
try {

    $dbuser = 'lbaw1641';
    $dbpass = 'zl50rg14';
    $host = 'dbm.fe.up.pt';
    $dbname = 'lbaw1641';

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
//Include library from lbaw framework
include_once($BASE_DIR . 'lib/helpers/functions.php');
include_once($BASE_DIR . 'lib/permissions/PagePermissions.class.php');
include_once($BASE_DIR . 'lib/permissions/Permission.class.php');
include_once($BASE_DIR . 'lib/permissions/AuthUser.class.php');
include_once($BASE_DIR . 'lib/permissions/AdminUser.class.php');
include_once($BASE_DIR . 'lib/permissions/ModUser.class.php');
include_once($BASE_DIR . 'lib/permissions/ResourcePermission.class.php');
include_once($BASE_DIR . 'lib/helpers/Html.class.php');

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
$smarty->assign('PERMISSION',	$_SESSION['permission']);


if (file_exists($BASE_DIR.'/images/users/'.$_SESSION['username'].'.png'))
    $photo_profile = '/images/users/'.$_SESSION['username'].'.png';
if (file_exists($BASE_DIR.'/images/users/'.$_SESSION['username'].'.jpg'))
    $photo_profile = '/images/users/'.$_SESSION['username'].'.jpg';
if (!$photo_profile) $photo_profile = '/images/person-flat.png';

$smarty->assign('AVATAR',	$photo_profile);
$_SESSION['logged_in'] = isset($_SESSION['logged_in']) ? $_SESSION['logged_in'] : false;
$smarty->assign('LOGGED_IN', $_SESSION['logged_in']);

unset($_SESSION['success_messages']);
unset($_SESSION['error_messages']);
unset($_SESSION['field_errors']);
unset($_SESSION['form_values']);