<?php
/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 3/16/17
 * Time: 9:47 AM
 */




function getUsers() {
    global $conn;
    $query = $conn->prepare("SELECT * FROM  User ORDER BY userid DESC");
    $query->execute();

    return $query->fetchAll();
}

function registerUser($username, $email, $password) {
    global $conn;
    $query = $conn->prepare("INSERT INTO User(username, email, password) VALUES (?, ?, ?)");
    $query->execute(array($username, $email, password_hash($password, PASSWORD_BCRYPT)));
}

function correctAuth($username, $password)
{
    global $conn;
    $query = $conn->prepare("SELECT * FROM User WHERE username = ?");
    $query->execute(array($username));

    $users = $query->fetchAll();

    if (sizeof($users) != 1) {
        return -1;
    }

    if (password_verify($password, $users[0]['password'])) {
        return true;
    } else {
        return false;
    }
}

function getUserByUsername($username) {
    global $conn;
    $query = $conn->prepare("SELECT userid, username, fullname, email, signdate 
FROM User WHERE username = ?");
    $query->execute(array($username));

    return $query->fetchAll();
}
