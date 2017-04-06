<?php
/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 4/6/17
 * Time: 10:26 PM
 */

function create_question($question) {

    global $conn;
    $query_publications=$conn->prepare("INSERT INTO publications(userid, body) VALUES (:userid, :body);
");
    $query_publications->execute($question);

    /*$query_questions=$conn->prepare("INSERT INTO questions(title, categoryid) VALUES (:title, 1);
");

    $query_questions->execute($query_questions);*/



}