<!-- Set your background image for this header on the line below. -->
<header class="intro-header" style="background-image: url('../../images/bg2.png')">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                <div class="site-heading">

                    <h1>AskMe</h1>
                    <br>

                    <div id="custom-search-input">
                        <div class="input-group col-lg-12">
                            <input type="text" class="form-control input-lg" placeholder="Search for a question..."/>
                            <span class="input-group-btn">
                                <a class="btn btn-info" href="../view/search_results.php">
                                    <i class="glyphicon glyphicon-search"></i>
                                </a>
                            </span>
                        </div>
                    </div>

                    <br><br>

                    <ul class = "list-inline intro-social-buttons">
                        <li>
                            <a href = "../view/about.php" class = "btn btn-warning btn-md">
                                <span class = "network-name">About Us</span>
                            </a>
                        </li>
                        <li>
                            <a href = "../view/create_question.php" class = "btn btn-success btn-md">
                                <span class = "network-name">Ask Now!</span>
                            </a>
                        </li>
                        <li>
                            <a href = "https://github.com/luistelmocosta/LBAW-FEUP" class = "btn btn-danger btn-md" target = "_blank"><i class = "fa fa-github fa-fw"></i>
                                <span class = "network-name">GITHUB</span></a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</header>


<div id="site-body" class="container">
    <div class="clearfix qa-main">
        <div class="home-left-inner">


            <div class="col-md-8"">

            <div id="tabs">
                <ul>
                    <li><a href="#tabs-1">Recent Questions</a></li>
                    <li><a href="#tabs-2">Unanswered Questions</a></li>
                    <li><a href="#tabs-3">Top Scored Questions</a></li>
                </ul>
                <div id="tabs-1">
                    {include file="recent_questions.tpl"}

                </div>
                <div id="tabs-2">
                    {include file="unanswered_questions.tpl"}
                </div>
                <div id="tabs-3">
                    {include file="top_scored_questions.tpl"}
                </div>

            </div>

        </div>

<<<<<<< HEAD:templates/index.tpl
        <div class="col-md-4 pull-right">
            <div id="home-right-position">
                <div class="widget cs_top_contributors">
                    <h3 class="widget-title">Top Scored Users</h3>
                    <div class="ra-tags-widget">
                        <ul class="top-users-list clearfix"><li class="top-user clearfix">
                                <div class="avatar" data-id="1" data-handle="admin">
                                    <a href="./user/admin" class="qa-avatar-link">
                                        <img src="../css/img/admin_icon.jpg" width="30"
                                             height="30" class="qa-avatar-image" alt=""></a></div><div class="top-user-data">
                                    <span class="points">520 points</span><a href="./user/admin" class="name">admin</a><p class="counts">
                                        <span>3 questions
                                        </span>
                                        <span>7 answers</span>
                                        <span>1 comments</span>
                                    </p>
                                </div>
                            </li>
                            <li class="top-user clearfix">
                                <div class="avatar" data-id="2" data-handle="Towhid"><a href="./user/Towhid" class="qa-avatar-link">
                                        <img src="../css/img/users.jpg" width="30" height="30"
                                             class="qa-avatar-image" alt="">
                                    </a>
                                </div>
                                <div class="top-user-data">
                                    <span class="points">510 points</span>
                                    <a href="./user/Towhid" class="name">Towhid</a>
                                    <p class="counts"><span>3 questions</span>
                                        <span>8 answers</span>
                                        <span>0 comments</span>
                                    </p>
                                </div>
                            </li>
                            <li class="top-user clearfix">
                                <div class="avatar" data-id="3" data-handle="HappyFace"><a href="./user/HappyFace" class="qa-avatar-link">
                                        <img src="../css/img/users.jpg"" width="30"
                                        height="30" class="qa-avatar-image" alt=""></a>
                                </div>
                                <div class="top-user-data">
                                    <span class="points">350 points</span>
                                    <a href="./user/HappyFace" class="name">HappyFace</a>
                                    <p class="counts"><span>3 questions</span>
                                        <span>3 answers</span>
                                        <span>1 comments</span>
                                    </p>
                                </div>
                            </li>
                            <li class="top-user clearfix">
                                <div class="avatar" data-id="21" data-handle="gurjyottheman">
                                    <a href="./user/gurjyottheman" class="qa-avatar-link">
                                        <img src="../css/img/users.jpg" width="30"
                                             height="30" class="qa-avatar-image" alt=""></a>
                                </div>
                                <div class="top-user-data"><span class="points">340 points</span>
                                    <a href="./user/gurjyottheman" class="name">gurjyottheman</a>
                                    <p class="counts"><span>3 questions</span>
                                        <span>4 answers</span>
                                        <span>0 comments</span>
                                    </p>
                                </div>
                            </li>
                            <li class="top-user clearfix">
                                <div class="avatar" data-id="7" data-handle="Inspector">
                                    <a href="./user/Inspector" class="qa-avatar-link">
                                        <img src="../css/img/users.jpg" width="30"
                                             height="30" class="qa-avatar-image" alt="">
                                    </a>
                                </div>
                                <div class="top-user-data">
                                    <span class="points">240 points</span>
                                    <a href="./user/Inspector" class="name">Inspector</a>
                                    <p class="counts">
                                        <span>2 questions</span>
                                        <span>2 answers</span>
                                        <span>0 comments</span>
                                    </p>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <br>
                    <br>
                    <div class="widget status" >
                        <h3 class="widget-title">Site Status</h3>
                        <canvas id="siteStatus" width="350" height="300" style="padding-left: 10px">

                        </canvas>
                    </div>

=======
    </div>

    <div class="col-md-4 pull-right">
        <div id="home-right-position">
            <div class="widget cs_top_contributors">
                <h3 class="widget-title">Top Scored Users</h3>
                <div class="ra-tags-widget">
                    <ul class="top-users-list clearfix"><li class="top-user clearfix">
                            <div class="avatar" data-id="1" data-handle="admin">
                                <a href="./user/admin" class="qa-avatar-link">
                                    <img src="images/admin_icon.jpg" width="30"
                                         height="30" class="qa-avatar-image" alt=""></a></div><div class="top-user-data">
                                <span class="points">520 points</span><a href="./user/admin" class="name">admin</a><p class="counts">
                                        <span>3 questions
                                        </span>
                                    <span>7 answers</span>
                                    <span>1 comments</span>
                                </p>
                            </div>
                        </li>
                        <li class="top-user clearfix">
                            <div class="avatar" data-id="2" data-handle="Towhid"><a href="./user/Towhid" class="qa-avatar-link">
                                    <img src="images/users.jpg" width="30" height="30"
                                         class="qa-avatar-image" alt="">
                                </a>
                            </div>
                            <div class="top-user-data">
                                <span class="points">510 points</span>
                                <a href="./user/Towhid" class="name">Towhid</a>
                                <p class="counts"><span>3 questions</span>
                                    <span>8 answers</span>
                                    <span>0 comments</span>
                                </p>
                            </div>
                        </li>
                        <li class="top-user clearfix">
                            <div class="avatar" data-id="3" data-handle="HappyFace"><a href="./user/HappyFace" class="qa-avatar-link">
                                    <img src="images/users.jpg"" width="30"
                                    height="30" class="qa-avatar-image" alt=""></a>
                            </div>
                            <div class="top-user-data">
                                <span class="points">350 points</span>
                                <a href="./user/HappyFace" class="name">HappyFace</a>
                                <p class="counts"><span>3 questions</span>
                                    <span>3 answers</span>
                                    <span>1 comments</span>
                                </p>
                            </div>
                        </li>
                        <li class="top-user clearfix">
                            <div class="avatar" data-id="21" data-handle="gurjyottheman">
                                <a href="./user/gurjyottheman" class="qa-avatar-link">
                                    <img src="images/users.jpg" width="30"
                                         height="30" class="qa-avatar-image" alt=""></a>
                            </div>
                            <div class="top-user-data"><span class="points">340 points</span>
                                <a href="./user/gurjyottheman" class="name">gurjyottheman</a>
                                <p class="counts"><span>3 questions</span>
                                    <span>4 answers</span>
                                    <span>0 comments</span>
                                </p>
                            </div>
                        </li>
                        <li class="top-user clearfix">
                            <div class="avatar" data-id="7" data-handle="Inspector">
                                <a href="./user/Inspector" class="qa-avatar-link">
                                    <img src="images/users.jpg" width="30"
                                         height="30" class="qa-avatar-image" alt="">
                                </a>
                            </div>
                            <div class="top-user-data">
                                <span class="points">240 points</span>
                                <a href="./user/Inspector" class="name">Inspector</a>
                                <p class="counts">
                                    <span>2 questions</span>
                                    <span>2 answers</span>
                                    <span>0 comments</span>
                                </p>
                            </div>
                        </li>
                    </ul>
>>>>>>> Setup:view/templates/index.tpl
                </div>

            </div>

        </div>

            <div class="col-lg-12" style="padding-top: 10px">
                <h3 class="bottom-notice" style="color: #185a66;">Looking for more? Browse the
                    <a href="/questions">complete list of questions</a>, or
                    <a href="/tags">popular tags</a>. Help us answer
                    <a href="/unanswered">unanswered questions</a>.
                </h3>
            </div>

    </div>

