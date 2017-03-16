<?php
/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 2/21/17
 * Time: 11:09 PM
 */

include_once('../lib/smarty/Smarty.class.php');


$BASE_DIR = '/home/luiscosta/PhpstormProjects/LBAW-FEUP/';
echo $BASE_DIR;
$BASE_URL = '/';
$smarty = new Smarty();
$smarty->template_dir = '../templates';
$smarty->compile_dir = '../templates_c';
$smarty->assign('BASE_URL', $BASE_URL);

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
$conn->exec('SET SCHEMA \'public\'');

$sql = 'SELECT * FROM User';


if (!$conn) {
    echo "Error : Unable to open database\n";
} else {
    echo '<script language="javascript">';
    echo 'alert("Database successfully connected!")';
    echo '</script>';
}

include($BASE_DIR . 'config/lib.php');




?>