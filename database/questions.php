<?php
/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 4/6/17
 * Time: 10:26 PM
 */

function create_question($question) {

    global $conn;
    $query=$conn->prepare("INSERT INTO publications(userid, body) VALUES (:userid, :body)");
    $query->execute($question);

}