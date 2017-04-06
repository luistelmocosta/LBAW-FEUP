<?php
/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 3/16/17
 * Time: 9:47 AM
 */




function getUsers() {
    global $conn;
    $query = $conn->prepare("SELECT * FROM  users ORDER BY userid DESC");
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

    $password = password_hash($password, PASSWORD_BCRYPT);
    $query->execute(array($username, $email, $password));

}

/**
 * @param $username
 * @param $password
 * @return bool
 */
function correctAuth($username, $password)


{
    global $conn;
    $stmt = $conn->prepare("SELECT * 
                            FROM users 
                            WHERE username = ?");
    $stmt->execute(array($username));
    $users = $stmt->fetchAll();


    if (sizeof($users) != 1) {
        return false;
    }

    if (crypt($password, $users[0]['password']) === $users[0]['password']) {
        return true;
    } else {
        return false;
    }
}


function getUserByUsername($username) {
    global $conn;
    $query = $conn->prepare("SELECT userid, username, fullname, email, signup_date 
FROM users WHERE username = ?");
    $query->execute(array($username));

    return $query->fetchAll();
}
