<?php

include_once($BASE_DIR . 'lib/helpers/functions.php');
include_once($BASE_DIR . 'lib/helpers/Html.class.php');

include_once($BASE_DIR . 'lib/permissions/PagePermissions.class.php');
include_once($BASE_DIR . 'lib/permissions/Permission.class.php');
include_once($BASE_DIR . 'lib/permissions/AuthUser.class.php');
include_once($BASE_DIR . 'lib/permissions/GuestUser.class.php');
include_once($BASE_DIR . 'lib/permissions/AdminUser.class.php');
include_once($BASE_DIR . 'lib/permissions/ModUser.class.php');
include_once($BASE_DIR . 'lib/permissions/PagePermissions.class.php');
include_once($BASE_DIR . 'lib/permissions/ResourcePermission.class.php');

include_once ($BASE_DIR . '/lib/smarty/Smarty.class.php');


$smarty = new Smarty();
$smarty->template_dir = '../templates';
$smarty->compile_dir = '../templates_c';
$smarty->assign('BASE_URL', $BASE_URL);


$_SESSION['logged_in'] = isset($_SESSION['logged_in']) ? $_SESSION['logged_in'] : false;
$smarty->assign('LOGGED_IN', $_SESSION['logged_in']);
