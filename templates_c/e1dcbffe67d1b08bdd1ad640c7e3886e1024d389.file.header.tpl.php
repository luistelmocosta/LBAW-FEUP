<?php /* Smarty version Smarty-3.1.15, created on 2017-03-06 16:57:22
         compiled from "/home/luiscosta/PhpstormProjects/LBAW-FEUP/common/header.tpl" */ ?>
<?php /*%%SmartyHeaderCode:134547721858bd86e253cb46-81816213%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'e1dcbffe67d1b08bdd1ad640c7e3886e1024d389' => 
    array (
      0 => '/home/luiscosta/PhpstormProjects/LBAW-FEUP/common/header.tpl',
      1 => 1488815077,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '134547721858bd86e253cb46-81816213',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_58bd86e2545d70_85849640',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_58bd86e2545d70_85849640')) {function content_58bd86e2545d70_85849640($_smarty_tpl) {?><html lang="en-US">
<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <title>AskMe</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link rel="stylesheet" type="text/css" href="../qa-styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">

    <link rel="stylesheet" type="text/css" href="../css/fonts/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="../css/fonts/font-awesome.css">
    <link rel="stylesheet" type="text/css" href="../css/styles/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../css/styles/main.css">
    <link rel="stylesheet" type="text/css" href="../css/styles/wide.css">
    <link rel="stylesheet" type="text/css" href="../css/styles/responsive.css">
    <link rel="stylesheet" type="text/css" href="../css/styles/theme-green.css">
    <link rel="stylesheet" type="text/css" href="../css/styles/dynamic.css">

    <link rel="alternate" type="application/rss+xml" href="./feed/qa.rss" title="Recent questions and answers">
    <link rel="search" type="application/opensearchdescription+xml" title="AskMe" href="./opensearch.xml">
    <script> theme_url = "http://demo.qa-themes.com/cleanstrap/qa-theme/cleanstrap";</script>
    <script type="text/javascript">
        var qa_root='.\/';
        var qa_request='';
    </script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="../js/qa-page.js" type="text/javascript"></script>
    <script type="text/javascript" src="http://demo.qa-themes.com/cleanstrap/qa-theme/cleanstrap/js/bootstrap.js"></script>
    <script type="text/javascript" src="http://demo.qa-themes.com/cleanstrap/qa-theme/cleanstrap/js/jquery.sparkline.min.js"></script>
    <script type="text/javascript" src="http://demo.qa-themes.com/cleanstrap/qa-theme/cleanstrap/js/jquery-ui.min.js"></script>
    <script type="text/javascript" src="http://demo.qa-themes.com/cleanstrap/qa-theme/cleanstrap/js/theme.js"></script>
    <script src="https://cdn.ckeditor.com/4.6.2/standard/ckeditor.js"></script>
</head>

<body id="nav-top" class="qa-template-qa qa-body-js-on">
<script type="text/javascript">
    var b=document.getElementsByTagName('body')[0];
    b.className=b.className.replace('qa-body-js-off', 'qa-body-js-on');
</script>
<header id="site-header" class="clearfix">
    <div class="qa-navbar navbar-default navbar-fixed-top " role="navigation">
        <a href="#" class="slide-mobile-menu icon-list"></a>
        <div class="site-logo">
            <a class="navbar-brand" title="AskMe" href="../views/index.php">
                <img class="navbar-site-logo" src="../css/img/logo.png">
            </a>
        </div>
        <ul class="nav navbar-nav category-nav pull-left">
            <li class="dropdown pull-left">
                <a data-toggle="dropdown"  href="#" class="category-toggle fa fa-folder">Categories</a>
                <ul class="category-list-drop dropdown-menu">
                    <li class="qa-nav-cat-item">
                        <a href="./categories" class=" qa-nav-cat-link qa-nav-cat-selected">All categories</a>
                    </li>
                    <li class="qa-nav-cat-item">
                        <a href="./cleanstrap" class=" qa-nav-cat-link" title="CleanStrap Theme">CleanStrap<span class="qa-nav-cat-note">33</span></a>
                    </li>
                    <li class="qa-nav-cat-item">
                        <a href="./widgets" class=" qa-nav-cat-link" title="CleanStrap widgets and drag &amp; drop builder">Widgets<span class="qa-nav-cat-note">3</span></a>
                    </li>
                    <li class="qa-nav-cat-item">
                        <a href="./Question2Answer" class=" qa-nav-cat-link" title="Questions about Question2Answer">Q2A platform<span class="qa-nav-cat-note">3</span></a>
                    </li>
                </ul>
            </li>
        </ul>
        <script>
            $(document).ready(function(){
                $("a").click(function(){
                    $(this).next().toggle();
                });
            });
        </script>

        <div class="qa-nav-main">
            <ul class="qa-nav-main-list" style="padding-top: 6px">
                <li class="qa-nav-main-item qa-nav-main-questions">
                    <a href="./questions" class="fa fa-question qa-nav-main-link" >Questions</a>
                </li>
                <li class="qa-nav-main-item qa-nav-main-unanswered">
                    <a href="./unanswered" class="fa fa-frown-o" >Unanswered</a>
                </li>
                <li class="qa-nav-main-item qa-nav-main-tag">
                    <a href="./tags" class="fa fa-tags qa-nav-main-link" >Tags</a>
                </li>
                <li class="qa-nav-main-item qa-nav-main-user">
                    <a href="./users" class="fa fa-users qa-nav-main-link">Users</a>
                </li>
            </ul>
            <div class="qa-nav-main-clear">
            </div>
        </div>


        <a class="btn login-register fa fa-sign-in" href="../views/sign.php" data-toggle="modal" data-target="#login-modal" title="Login or Register"></a>

        <form method="get" action="" class="navbar-form navbar-right form-search" role="search">

            <span class="fa fa-search" style="position: fixed;padding-top: 8px;padding-left: 10px;"></span>
            <input type="text" name="q" value="" class="form-control search-query" placeholder="Search" autocomplete="off">

        </form>
    </div>
</header>

</body><?php }} ?>
