<?php
include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/questions.php');

if(!$_POST['psearch']) {
    $_SESSION['error_messages'][] = 'Search text required';
    $_SESSION['form_values'] = $_POST;
    back();
}
else $pstext = $_POST['psearch'];

$_SESSION['pstext'] = $pstext;

try {

    $search_res = search_questions($pstext);

    $_SESSION['search_res'] = $search_res;

    redirect('controller/pages/questions/search_results.php?search=' .  $pstext);

} catch (PDOException $e) {
    dd($e->getMessage());
    $_SESSION['error_messages'][] = "Your input is incorrect";
}