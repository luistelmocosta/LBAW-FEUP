<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/admin.php');
include_once($BASE_DIR . 'database/users.php');

$userid = auth_user('userid');
$user = userProfile($userid)[0];

$cat = $_POST['newCat'];

$alreadyExists = checkIfCatExists($cat)[0]['count'];

if($alreadyExists > 0) {
    $_SESSION['error_messages'][] = 'Category already exists';
    redirect('controller/pages/admin/admin.php');
}

try {
    createCategory($cat);
    $_SESSION['success_messages'][] = 'Category successfully created';
    redirect('controller/pages/admin/admin.php');

} catch (PDOException $e) {
    dd($e->getMessage());
    $_SESSION['error_messages'][] = "Your input is incorrect";
}