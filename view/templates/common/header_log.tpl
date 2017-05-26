<html lang="en-US" xmlns="http://www.w3.org/1999/html">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">

    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    {HTML::script('success_messages.js')}


    <script>
        $( function() {
            $( "#tabs" ).tabs();
        } );
    </script>

    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="{$BASE_URL}css/fonts/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="{$BASE_URL}css/fonts/font-awesome.css">
    <link rel="stylesheet" type="text/css" href="{$BASE_URL}css/styles/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="{$BASE_URL}css/styles/main.css">
    <link rel="stylesheet" type="text/css" href="{$BASE_URL}css/styles/responsive.css">
    <link rel="stylesheet" type="text/css" href="{$BASE_URL}css/styles/clean-blog.min.css">
    <link rel="stylesheet" type="text/css" href="{$BASE_URL}css/styles/vote.css">

    <!-- JS -->
    <script type="text/javascript" src="{$BASE_URL}javascript/vendor/bootstrap.js"></script>
    <script type="text/javascript" src="{$BASE_URL}javascript/vendor/Chart.js"></script>
    <script src="https://cdn.ckeditor.com/4.6.2/standard/ckeditor.js"></script>

</head>

<body>
<nav class="navbar-default navbar-custom navbar-fixed-top" style="background: #2d2727;">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header page-scroll">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                Menu <i class="fa fa-bars"></i>
            </button>
            <div class="site-logo">
                <a class="navbar-brand" title="AskMe" href="{$BASE_URL}index.php">
                    <img class="navbar-site-logo" src="{$BASE_URL}images/logo.png">
                </a>
            </div>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">


            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="{$BASE_URL}controller/pages/questions/categories.php">Categories</a>
                </li>
                <li>
                    <a href="{$BASE_URL}controller/pages/users/top_scored_users.php">Top Users</a>
                </li>

                <ul class="nav navbar-nav navbar-avatar pull-right">
                    <li class="dropdown pull-right" id="menuLogin">
                        <div class="log_menu" style="padding: 7px">
                            <a id="profile-link" data-toggle="dropdown" href="#" class="avatar" style="padding-top: 10px">
                                <img src="{$avatar}">
                            </a>
                            <ul class="user-nav dropdown-menu">
                                <li class="user-nav-profile"><a class="fa fa-id-card" href="{$BASE_URL}controller/pages/users/profile.php" title="Profile">Profile</a></li>
                                {if ($PERMISSION == 'admin')}
                                <li class="user-nav-favorites"><a class="fa fa-user-md" href="{$BASE_URL}controller/pages/admin/admin.php" title="Admin Panel">Admin CP</a></li>
                                {/if}
                                {if ($PERMISSION == 'mod')}
                                    <li class="user-nav-favorites"><a class="fa fa-user-md" href="{$BASE_URL}controller/pages/admin/admin.php" title="Mod Panel">Mod CP</a></li>
                                {/if}
                                <li><a class="fa fa-power-off" href="{$BASE_URL}controller/actions/users/logout.php"> Logout </a></li>
                            </ul>
                        </div>
                    </li>
                </ul>
            </ul>
        </div>
    </div>

</nav>

<div style="padding-top:30px;"> </div>

{$_SESSION['roleid']}
<br>
<br>