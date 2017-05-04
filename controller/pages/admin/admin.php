<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');
include_once($BASE_DIR . 'database/questions.php');

PagePermissions::create('auth')->check();

$userid = auth_user('userid');
$user = userProfile($userid)[0];

$numUsers = getNumUsers()[0]['count'];

$limit = 4;

// How many pages will there be
$pages = ceil($numUsers / $limit);

// What page are we currently on?
$page = min($pages, filter_input(INPUT_GET, 'page', FILTER_VALIDATE_INT, array(
    'options' => array(
        'default'   => 1,
        'min_range' => 1,
    ),
)));

// Calculate the offset for the query
$offset = ($page - 1)  * $limit;

// Some information to display to the user
$start = $offset + 1;
$end = min(($offset + $limit), $numUsers);

// The "back" link
$prevlink = ($page > 1) ? '<a href="?page=1" title="First page">&laquo;</a> <a href="?page=' . ($page - 1) . '" title="Previous page">&lsaquo;</a>'
    : '<span class="disabled">&laquo;</span> <span class="disabled">&lsaquo;</span>';

// The "forward" link
$nextlink = ($page < $pages) ? '<a href="?page=' . ($page + 1) . '" title="Next page">&rsaquo;</a> <a href="?page=' . $pages . '" title="Last page">&raquo;</a>'
    : '<span class="disabled">&rsaquo;</span> <span class="disabled">&raquo;</span>';

// Display the paging information


$users = getUsersPag($offset, $limit);
$questions = recent_questions();

$smarty->assign('user', $user);
$smarty->assign('users', $users);
$smarty->assign('questions', $questions);

$smarty->display('common/header_log.tpl');
$smarty->display('admin.tpl');
$smarty->display('common/footer.tpl');