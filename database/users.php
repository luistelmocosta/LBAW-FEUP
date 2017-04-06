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

/**
 * @param $username
 * @param $email
 * @param $password
 */
function registerUser($username, $email, $password) {
    global $conn;
    $query = $conn->prepare("INSERT INTO users(username, email, password) VALUES (?, ?, ?)");
    $query->execute(array($username, $email, password_hash($password, PASSWORD_BCRYPT)));
}

/**
 * @param $username
 * @param $password
 * @return bool
 */
function correctAuth($username, $password)


{

    echo '<script language="javascript">';
    echo 'console.log("Incorrect auth2!")';
    echo '</script>';

    global $conn;
    $stmt = $conn->prepare("SELECT * 
                            FROM users 
                            WHERE username = ?");

    echo '<script language="javascript">';
    echo 'console.log("Incorrect auth3!")';
    echo '</script>';
    $stmt->execute(array($username));

    echo '<script language="javascript">';
    echo 'console.log("Incorrect auth4!")';
    echo '</script>';
    $users = $stmt->fetchAll();

    echo '<script language="javascript">';
    echo 'console.log("Incorrect auth5!")';
    echo '</script>';

    if (sizeof($users) != 1) {
        return false;
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
FROM users WHERE username = ?");
    $query->execute(array($username));

    return $query->fetchAll();
}
