<?php
/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 2/21/17
 * Time: 11:09 PM
 */

session_start();


$BASE_DIR = '/home/luiscosta/PhpstormProjects/LBAW-FEUP/';
$BASE_URL = '/LBAW-FEUP/';


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


/*if (!$conn) {
    echo "Error : Unable to open database\n";
} else {

    echo "DATABASE OPENED!";

}*/

include($BASE_DIR . 'config/lib.php');

?>