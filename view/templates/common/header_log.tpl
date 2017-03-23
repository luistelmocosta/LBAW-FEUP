<html lang="en-US" xmlns="http://www.w3.org/1999/html">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">

    <title>AskMe</title>

    <meta http-equiv="X-UA-Compatible" content="IE=edge">

    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <script>
        $( function() {
            $( "#tabs" ).tabs();
        } );
    </script>


    <link rel="stylesheet" type="text/css" href="../css/fonts/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="../css/fonts/font-awesome.css">
    <link rel="stylesheet" type="text/css" href="../css/styles/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../css/styles/main.css">
    <link rel="stylesheet" type="text/css" href="../css/styles/responsive.css">

    <!-- Theme CSS -->
    <link href="../css/styles/clean-blog.min.css" rel="stylesheet">

    <script type="text/javascript" src="../javascript/vendor/bootstrap.js"></script>
    <script src="https://cdn.ckeditor.com/4.6.2/standard/ckeditor.js"></script>

</head>

<body id="nav-top" class="qa-template-qa qa-body-js-on"> </body>
<script type="text/javascript">
    var b=document.getElementsByTagName('body')[0];
    b.className=b.className.replace('qa-body-js-off', 'qa-body-js-on');
</script>

<script>
    $(document).ready(function(){
        $("a").click(function(){
            $(this).next().toggle();
        });
    });
</script>
<!-- Navigation -->
<nav class="navbar navbar-default navbar-custom navbar-fixed-top" style="background: #2d2727;">
    <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header page-scroll">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                Menu <i class="fa fa-bars"></i>
            </button>
            <div class="site-logo">
                <a class="navbar-brand" title="AskMe" href="../index.php">
                    <img class="navbar-site-logo" src="../images/logo3.png">
                </a>
            </div>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">


            <ul class="nav navbar-nav navbar-right">
                <li>
                    <a href="../controller/pages/questions.php">Questions</a>
                </li>
                <li>
                    <a href="../controller/pages/top_scored_users.php">Top Users</a>
                </li>

                <ul class="nav navbar-nav navbar-avatar pull-right">
                    <li class="dropdown pull-right" id="menuLogin">
                        <div class="log_menu" style="padding: 7px">
                        <a id="profile-link" data-toggle="dropdown" href="#" class="avatar">
                            <img src="http://www.gravatar.com/avatar/8b21c0ba9bf921fa9aecfbfa62e26e08?s=30">						</a>
                        <ul class="user-nav dropdown-menu">
                            <li class="user-nav-profile"><a class="fa fa-id-card" href="../controller/pages/profile.php" title="Profile">Profile</a></li>
                            <li class="user-nav-account"><a class="fa fa-cog" href="../view/account.php" title="Account">Account</a></li>
                            <li class="user-nav-favorites"><a class="fa fa-user-md" href="../controller/pages/admin.php" title="Admin Panel">Admin CP</a></li>
                            <li><a class="fa fa-power-off" href="../index.php"> Logout </a></li>
                        </ul>
                        </div>
                    </li>
                </ul>

            </ul>
        </div>

    </div>

</nav>
<br>
<br>
