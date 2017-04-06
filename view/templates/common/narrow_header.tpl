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

    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="../../../css/fonts/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="../../../css/fonts/font-awesome.css">
    <link rel="stylesheet" type="text/css" href="../../../css/styles/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../../css/styles/main.css">
    <link rel="stylesheet" type="text/css" href="../../../css/styles/responsive.css">
    <link rel="stylesheet" type="text/css" href="../../../css/styles/clean-blog.min.css">

    <!-- JS -->
    <script type="text/javascript" src="../../../javascript/vendor/bootstrap.js"></script>
    <script type="text/javascript" src="../../../javascript/Chart.js"></script>
    <script type="text/javascript" src="../../../javascript/main.js"></script>
    <script src="https://cdn.ckeditor.com/4.6.2/standard/ckeditor.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.js"></script>

</head>


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
                    <img class="navbar-site-logo" src="../../../images/logo3.png">
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

                <li>
                    <a href="../../../controller/pages/users/signin.php" class="fa fa-sign-in" title="Login or Register"></a>
                </li>
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container -->

</nav>
<br>
<br>