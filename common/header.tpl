<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <link href="../css/styles/bootstrap.css" rel="stylesheet" />

    <link href="../css/styles/ie.css" rel="stylesheet" />
    <link href="../css/styles/font.css" rel="stylesheet" />
    <link href="../css/styles/dynamic.css" rel="stylesheet" />
    <link href="../css/styles/admin.css" rel="stylesheet" />
    <link href="../css/styles/main.css" rel="stylesheet" />
    <link href="../css/styles/responsive.css" rel="stylesheet" />
    <link href="../css/styles/rtl.css" rel="stylesheet" />
    <link href="../css/styles/spectrum.css" rel="stylesheet" />
    <link href="../css/styles/wide.css" rel="stylesheet" />
    <link href="../css/styles/theme-green.css" rel="stylesheet" />
    <!--     Font Awesome     -->
    <link href="http://netdna.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">

    <link href='http://fonts.googleapis.com/css?family=Grand+Hotel' rel='stylesheet' type='text/css'>
    <script src="https://google-code-prettify.googlecode.com/svn/loader/run_prettify.js"></script>
    <script src="//rawgithub.com/ashleydw/lightbox/master/dist/ekko-lightbox.js"></script>
    <script>
        (document).ready(function() {
            $('i.glyphicon-thumbs-up, i.glyphicon-thumbs-down').click(function(){
                var $this = $(this),
                    c = $this.data('count');
                if (!c) c = 0;
                c++;
                $this.data('count',c);
                $('#'+this.id+'-bs3').html(c);
            });
            $(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
                event.preventDefault();
                $(this).ekkoLightbox();
            });
        });
    </script>

</head>
<header id="site-header" class="clearfix">
    <div class="qa-navbar navbar-default navbar-fixed-top " role="navigation">
        <a href="#" class="slide-mobile-menu icon-list"></a>
        <div class="site-logo">
            <a class="navbar-brand" title="CleanStrap Demo" href="http://demo.qa-themes.com/cleanstrap/">
                <img class="navbar-site-logo" src="../css/img/askme.png">
            </a>
        </div>
        <a id="nav-ask-btn" href="./ask" class="btn btn-sm">Ask Question</a>
        <a id="nav-ask-btn" href="./ask" class="btn btn-sm header-ask-button icon-question-sign"></a>
        <ul class="nav navbar-nav category-nav pull-left">
            <li class="dropdown pull-left">
                <a data-toggle="dropdown" href="#" class="category-toggle icon-folder-close">Categories</a>
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

        <div class="qa-nav-main">
            <ul class="qa-nav-main-list">
                <li class="qa-nav-main-item qa-nav-main-questions">
                    <a href="./questions" class="icon-question-sign qa-nav-main-link">Questions</a>
                </li>
                <li class="qa-nav-main-item qa-nav-main-unanswered">
                    <a href="./unanswered" class="icon-sad qa-nav-main-link">Unanswered</a>
                </li>
                <li class="qa-nav-main-item qa-nav-main-tag">
                    <a href="./tags" class="icon-tags2 qa-nav-main-link">Tags</a>
                </li>
                <li class="qa-nav-main-item qa-nav-main-user">
                    <a href="./users" class="icon-users qa-nav-main-link">Users</a>
                </li>
            </ul>
            <div class="qa-nav-main-clear">
            </div>
        </div>

        <a class="btn login-register icon-login" href="#" data-toggle="modal" data-target="#login-modal" title="Login or Register"></a>

        <form method="get" action="./search" class="navbar-form navbar-right form-search" role="search">

            <span class="icon-search"></span>
            <input type="text" name="q" value="" class="form-control search-query" placeholder="Search" autocomplete="off">

        </form>
    </div>
</header>