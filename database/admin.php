<?php

function getNumEditors(){
    global $conn;
    $stmt = $conn->prepare("SELECT COUNT(*) FROM users WHERE roleid = 3");
    $stmt->execute();

    return $stmt->fetchAll();
}

function getNumAdmins(){
    global $conn;
    $stmt = $conn->prepare("SELECT COUNT(*) FROM users WHERE roleid = 2");
    $stmt->execute();

    return $stmt->fetchAll();
}

function getNumModReg(){
    global $conn;
    $stmt = $conn->prepare("SELECT COUNT(*) FROM modregisters");
    $stmt->execute();

    return $stmt->fetchAll();
}

function getNumBans(){
    global $conn;
    $stmt = $conn->prepare("SELECT COUNT(*) FROM bans");
    $stmt->execute();

    return $stmt->fetchAll();
}

function banUser($adminid, $userid){

    global $conn;
    $stmt = $conn->prepare("INSERT INTO modregisters(reason, userid_author, userid_target) VALUES ('Offensive Speech', $adminid, $userid)");
    $stmt->execute();

    $banID = getNumBans()[0]['count'] + 1;
    $stmt2 = $conn->prepare("INSERT INTO bans(banid, end_date) VALUES ($banID, '2018-03-29 01:05:00')");
    $stmt2->execute();
}

