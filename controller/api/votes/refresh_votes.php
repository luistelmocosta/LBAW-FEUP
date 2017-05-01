<?php

PagePermissions::create('auth')->check();

$values = ['1', '-1'];
PagePermissions::create('auth')->check();

if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    echo "Invalid Params (id)";
    exit();
}

if (!isset($_GET['value']) || !in_array($_GET['value'], $values)) {
    echo "Invalid Params (values)";
    exit();
}

$publicationid = (int)$_GET['id'];
$values = $_GET['value'];

$rating = get_publication_rating($publicationid);

print_r($rating);
die();

echo json_encode(['rating' => $rating]);
exit();