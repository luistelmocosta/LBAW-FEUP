<?php

function getNumUsers(){
    global $conn;
    $stmt = $conn->prepare("SELECT COUNT(*) FROM users");
    $stmt->execute();

    return $stmt->fetchAll();
}

function users_pag($page = 0)
{
    global $conn;
    $limit = 4;
    $skip = $limit * $page;
    $stmt = $conn->prepare("SELECT * FROM get_users_pag(:skip, :limit)");
    $stmt->execute(['limit' => $limit, 'skip' => $skip]);
    $rows = $stmt->fetchAll();

    return $rows;
}

function getUsersPag($skip, $limit) {
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM get_users_pag(:skip, :limit)");
    $stmt->execute(['limit' => $limit, 'skip' => $skip]);
    $rows = $stmt->fetchAll();

    return $rows;
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

    $query = $conn->prepare("SELECT userid, username, fullname, email, signup_date, userroles.rolename 
FROM users INNER JOIN userroles ON users.roleid = userroles.roleid WHERE username = ?");
    $query->execute(array($username));

    return $query->fetch();
}

function getUserIDByUsername($username) {
    global $conn;
    $query = $conn->prepare("SELECT userid 
FROM users WHERE username = ?");
    $query->execute(array($username));

    return $query->fetchAll();
}

function getUserNameByUserID($userID){
    global $conn;
    $query = $conn->prepare("SELECT username
FROM users WHERE userid = ?");
    $query->execute(array($userID));

    return $query->fetchAll();
}

function check_location($locationname){
    global $conn;
    $query = $conn->prepare("SELECT locationid FROM locations WHERE locations.name = '$locationname'");
    $query->execute();

    return $query->fetchAll();
}

function create_location($locationname){
    global $conn;
    $query = $conn->prepare("INSERT INTO locations(name) VALUES ('$locationname')");
    $query->execute();

    return true;
}

function userProfile($userid) {

    global $conn;
    $query = $conn->prepare("SELECT * FROM user_profile(:userid)");
    $query->execute(['userid' => $userid]);

    return $query->fetchAll();
}

function update_user_profile($update_user) {

    global $conn;
    $query = $conn->prepare("SELECT * FROM update_user_profile(:userid, :fullname, :email, :location, :about)");
    $query->execute($update_user);

    return true;
}

function top_scored_users() {

    global $conn;
    $query = $conn->prepare("SELECT * FROM top_scored_users() LIMIT 5");
    $query->execute();

    return $query->fetchAll();
}

function top_scored_users_page() {

    global $conn;
    $query = $conn->prepare("SELECT * FROM top_scored_users() LIMIT 18");
    $query->execute();

    return $query->fetchAll();
}

function check_ban($userid){

    global $conn;
    $query = $conn->prepare("SELECT COUNT(*) FROM modregisters INNER JOIN bans ON modregisters.modregisterid = bans.banid WHERE userid_target = $userid");
    $query->execute();

    return $query->fetchAll();
}

function get_mod_reg_ban_by_user_id($userid){
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM modregisters INNER JOIN bans ON modregisters.modregisterid = bans.banid WHERE modregisters.userid_target = $userid");
    $stmt->execute();

    return $stmt->fetchAll();
}

function get_mod_reg_warn_by_user_id($userid){
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM modregisters INNER JOIN warnings ON modregisters.modregisterid = warnings.warningid WHERE modregisters.userid_target = $userid");
    $stmt->execute();

    return $stmt->fetchAll();
}

function changeUserPwd($username, $password) {
    global $conn;

    $query = $conn->prepare("UPDATE users SET password = ? WHERE users.username = '$username'");

    $password = password_hash($password, PASSWORD_BCRYPT);
    $query->execute(array($password));

}