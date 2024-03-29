<?php
function dd()
{
    $variables = func_get_args();
    foreach ($variables as $variable) {
        var_dump($variable);
    }
    exit();
}

function back()
{
    header('Location: ' . $_SERVER['HTTP_REFERER']);
    exit();
}

function redirect($path = '')
{
    global $BASE_URL;
    header('Location: ' . $BASE_URL . $path);
    exit();
}

function url($uri = '', $params = [])
{
    global $BASE_URL;

    if ($uri !== '' and (!endsWith($uri, '/') or !endsWith($uri, '.php'))) {
        $uri .= '.php';
    }

    if (!empty($params)) {
        $get = http_build_query($params);
        $uri .= '?' . $get;
    }

    return $BASE_URL . $uri;
}

function questionUrl($publicationid)
{
    return url('controller/pages/questions/question', ['question' => $publicationid]);
}

function editQuestionUrl($questionid)
{
    return url('controller/pages/questions/edit_question', ['question' => $questionid]);
}

function editAnswerUrl($answerid)
{
    return url('controller/pages/questions/edit_answer', ['answer' => $answerid]);
}

function questionSolvedUrl($question_id, $answer_id)
{

    return url('controller/api/questions/mark_as_solved', ['question' => $question_id], ['answer' => $answer_id]);
}

function answerUrl($answer_id)
{
    return url('pages/questions/details', ['answer' => $answer_id]);
}

function categoryQuestionsUrl($category_id)
{
    return url('controller/pages/questions/category_questions', ['category' => $category_id]);
}

function profileUrl($user_id)
{
    return url('controller/pages/users/profile', ['userid' => $user_id]);
}

function old($name, $default = '')
{
    global $FORM_VALUES;

    if (isset($FORM_VALUES[$name])) {
        return $FORM_VALUES[$name];
    }

    return $default;
}

function auth_user($property = null)
{
    if ($property && isset($_SESSION['user'][$property])) {
        return $_SESSION['user'][$property];
    }

    return $_SESSION['user'];
}

function query_build_for_num_args($array)
{
    $tags_query = '';
    for ($i = 0; $i < count($array); $i++) {
        $tags_query .= '?, ';
    }

    if (strlen($tags_query) > 1) {
        $tags_query = substr($tags_query, 0, -2);
    }

    return $tags_query;
}

function startsWith($haystack, $needle)
{
    // search backwards starting from haystack length characters from the end
    return $needle === "" || strrpos($haystack, $needle, -strlen($haystack)) !== false;
}

function endsWith($haystack, $needle)
{
    // search forward starting from end minus needle length characters
    return $needle === "" || (($temp = strlen($haystack) - strlen($needle)) >= 0 && strpos($haystack, $needle,
            $temp) !== false);
}