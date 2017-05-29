<?php

include_once('../../../config/init.php');
include_once($BASE_DIR . 'database/users.php');
include_once($BASE_DIR . 'database/questions.php');

PagePermissions::create('auth')->check();

$permission = $_SESSION['permission'];


if(isset($_GET['userid'])) {
    $userid = $_GET['userid'];
}
else {
    $userid = auth_user('userid');
    $own = true;
}

$avatar = $_SESSION['user']['avatar'];

$user = userProfile($userid)[0];
$badges = userBadges($userid);
$avatarprof = $user['avatar'];

if($_SESSION['logged_in']) {

    $smarty->assign('avatar', $avatar);
    $smarty->assign('avatarprof', $avatarprof);

    $smarty->display('common/header_log.tpl');
} else {
    $smarty->display('common/narrow_header.tpl');
}

foreach ($badges as $key => $badge) {

    if (file_exists($BASE_DIR.'/images/badges/'.$badge['name'].'.png'))
        $badge_picture = '/images/badges/'.$badge['name'].'.png';
        $badges[$key]['badge_picture'] = $badge_picture;
    if (file_exists($BASE_DIR.'/images/users/'.$badge['name'].'.jpg'))
        $badge_picture = '/images/users/'.$badge['name'].'.jpg';
}


$user_questions = get_questions_by_user_id($userid);
$user_mod_regs_bans =  get_mod_reg_ban_by_user_id($userid);
$user_mod_regs_warns = get_mod_reg_warn_by_user_id($userid);

foreach ($user_questions as $key => $question) {
    $user_questions[$key]['creation_date'] = time_elapsed_string($user_questions[$key]['creation_date']);
}

function time_elapsed_string($time_ago) {
    $time_ago = strtotime($time_ago);
    $cur_time   = time();
    $time_elapsed   = $cur_time - $time_ago - 3600;
    $seconds    = $time_elapsed ;
    $minutes    = round($time_elapsed / 60 );
    $hours      = round($time_elapsed / 3600);
    $days       = round($time_elapsed / 86400 );
    $weeks      = round($time_elapsed / 604800);
    $months     = round($time_elapsed / 2600640 );
    $years      = round($time_elapsed / 31207680 );
    // Seconds
    if($seconds <= 60){
        return "just now";
    }
    //Minutes
    else if($minutes <=60){
        if($minutes==1){
            return "one minute ago";
        }
        else{
            return "$minutes minutes ago";
        }
    }
    //Hours
    else if($hours <=24){
        if($hours==1){
            return "an hour ago";
        }else{
            return "$hours hrs ago";
        }
    }
    //Days
    else if($days <= 7){
        if($days==1){
            return "yesterday";
        }else{
            return "$days days ago";
        }
    }
    //Weeks
    else if($weeks <= 4.3){
        if($weeks==1){
            return "a week ago";
        }else{
            return "$weeks weeks ago";
        }
    }
    //Months
    else if($months <=12){
        if($months==1){
            return "a month ago";
        }else{
            return "$months months ago";
        }
    }
    //Years
    else{
        if($years==1){
            return "one year ago";
        }else{
            return "$years years ago";
        }
    }
}

$smarty->assign('user', $user);
$smarty->assign('user_questions', $user_questions);
$smarty->assign('user_mod_regs_bans', $user_mod_regs_bans);
$smarty->assign('user_mod_regs_warns', $user_mod_regs_warns);

$smarty->assign('permission', $permission);
$smarty->assign('own', $own);
$smarty->assign('badges', $badges);

$smarty->display('profile.tpl');
$smarty->display('common/footer.tpl');