<?php
/**
 * Created by PhpStorm.
 * User: luiscosta
 * Date: 4/6/17
 * Time: 10:26 PM
 */

function create_question($question) {

    global $conn;
    $query_publications=$conn->prepare("SELECT * FROM insert_into_questions(:body, :userid, :title, :categoryid);
");
    $query_publications->execute($question);

    /*$query_questions=$conn->prepare("INSERT INTO questions(title, categoryid) VALUES (:title, 1);
");

    $query_questions->execute($query_questions);*/



}

function get_categories() {
    global $conn;
    $query=$conn->prepare("SELECT categories.name FROM categories");
    $query->execute();
    return $query->fetchAll();
}

function get_tags_from_questions($questionid) {
    global $conn;
    $query=$conn->prepare("SELECT tags.tagid, tags.name
    FROM tags INNER JOIN questiontags ON tags.tagid = questiontags.tagid
    WHERE questiontags.questionid = questionid");

    $query->execute(['question' => $questionid]);
    return $query->fetchAll();
}

function get_categoryID_by_name($category) {
    global $conn;
    $query=$conn->prepare("SELECT categoryid FROM categories WHERE name = ?");
    $query->execute(array($category));


    return ($query->fetch()['categoryid']);
}