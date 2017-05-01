<?php
/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 4/26/17
 * Time: 2:20 PM
 */

function publication_is_voted($publicationid) {
    global $conn;
    $stmt = $conn->prepare("SELECT * 
                            FROM votes 
                            WHERE userid = :user AND publicationid = :question");
    $stmt->execute(['user' => auth_user('userid'), 'question' => $publicationid]);
    $votes = $stmt->fetch();
    if ($votes === false) {
        return 0;
    }
    if ($votes['values']) {
        return $votes['values'];
    }
    return -1;
}

function create_vote($publicationid, $value) {
    global $conn;
    $stmt = $conn->prepare("INSERT INTO votes(values, publicationid, userid) VALUES (:values, :publicationid, :userid)");
    $stmt->execute([
        'userid'  => auth_user('userid'),
        'publicationid'    => $publicationid,
        'values' => $value==1?1:-1
    ]);
}

function update_vote($publicationid, $value) {
    global $conn;
    $stmt = $conn->prepare("UPDATE votes SET values = :values WHERE publicationid = :publicationid AND userid = :userid");
    $stmt->execute([
        'userid'  => auth_user('userid'),
        'publicationid'    => $publicationid,
        'values' => $value==1?1:-1
    ]);
}

function delete_vote($publicationid) {
    global $conn;
    $stmt = $conn->prepare("DELETE FROM votes WHERE publicationid = :publicationid AND userid = :userid");
    $stmt->execute([
        'userid'  => auth_user('userid'),
        'publicationid'    => $publicationid
    ]);
}



