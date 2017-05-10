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

    $banID = getNumModReg()[0]['count'];
    $stmt2 = $conn->prepare("INSERT INTO bans(banid, end_date) VALUES ($banID, '2018-03-29 01:05:00')");
    $stmt2->execute();
}

function ban_info($userid){

    global $conn;
    $query = $conn->prepare("SELECT * FROM modregisters INNER JOIN bans ON modregisters.modregisterid = bans.banid WHERE userid_target = $userid");
    $query->execute();

    return $query->fetchAll();
}

function unBanUser($userid){

    $ban = ban_info($userid);

    $banID = $ban[0]['banid'];

    global $conn;

    $stmt2 = $conn->prepare("DELETE FROM bans WHERE bans.banid = $banID");
    $stmt2->execute();
}
