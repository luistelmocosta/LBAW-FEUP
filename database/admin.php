<?php

function getNumModerators(){
    global $conn;
    $stmt = $conn->prepare("SELECT COUNT(*) FROM users WHERE roleid = 2");
    $stmt->execute();

    return $stmt->fetchAll();
}

function getNumAdmins(){
    global $conn;
    $stmt = $conn->prepare("SELECT COUNT(*) FROM users WHERE roleid = 3");
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

function getLastModRegID(){
    global $conn;
    $stmt = $conn->prepare("SELECT modregisterid FROM modregisters ORDER BY modregisterid DESC LIMIT 1");
    $stmt->execute();

    return $stmt->fetchAll();
}

function modReg($adminid, $userid, $reason){
    global $conn;
    $stmt = $conn->prepare("INSERT INTO modregisters(reason, userid_author, userid_target) VALUES ('$reason', $adminid, $userid)");
    $stmt->execute();
}

function banUser($adminid, $userid, $reason, $end_date){

    modReg($adminid, $userid, $reason);

    global $conn;
    $banID = getLastModRegID()[0]['modregisterid'];
    $stmt2 = $conn->prepare("INSERT INTO bans(banid, end_date) VALUES ($banID, '$end_date')");
    $stmt2->execute();
}

function warnUser($adminid, $userid, $reason){

    modReg($adminid, $userid, $reason);

    global $conn;
    $warnID = getLastModRegID()[0]['modregisterid'];
    $stmt2 = $conn->prepare("INSERT INTO warnings(warningid) VALUES($warnID)");
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

function checkIfCatExists($cat){
    global $conn;
    $query = $conn->prepare("SELECT COUNT(*) FROM categories WHERE categories.name = '$cat'");
    $query->execute();

    return $query->fetchAll();
}

function createCategory($cat){
    global $conn;
    $query = $conn->prepare("INSERT INTO categories(name) VALUES('$cat')");
    $query->execute();
}

function changePermissions($userid, $perm){
    global $conn;
    $query = $conn->prepare("UPDATE users SET roleid=$perm WHERE userid = $userid");
    $query->execute();
}
