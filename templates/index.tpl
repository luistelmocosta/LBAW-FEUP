<!-- Set your background image for this header on the line below. -->
<header class="intro-header" style="background-image: url('../css/img/bg2.png')">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                <div class="site-heading">
                    <h1>AskMe</h1>
                    <br>

                    <div id="custom-search-input">
                        <div class="input-group col-lg-12">
                            <input type="text" class="form-control input-lg" placeholder="Search for a question..." />
                            <span class="input-group-btn">
                        <button class="btn btn-info" type="button">
                            <i class="glyphicon glyphicon-search"></i>
                        </button>
                    </span>
                        </div>
                    </div>

                    <br><br>

                    <ul class = "list-inline intro-social-buttons">
                        <li>
                            <a href = "" class = "btn btn-warning btn-md">
                                <span class = "network-name">About Us</span>
                            </a>
                        </li>
                        <li>
                            <a href = "" class = "btn btn-success btn-md">
                                <span class = "network-name">Ask Now!</span>
                            </a>
                        </li>
                        <li>
                            <a href = "http://fe.up.pt" class = "btn btn-danger btn-md" target = "_blank"><i class = "fa fa-github fa-fw"></i>
                                <span class = "network-name">GITHUB</span></a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</header>


<body id="site-body" class="container">
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
                </div>
                <div class="widget cs_site_status">																						<h3 class="widget-title">Site Status</h3>
                    <div class="ra-site-status-widget">
                        <div class="site-status-inner clearfix"><div class="bar-float" style="float: none; width: 100%;"><div class="sparkline" data-type="bar" data-bar-color="#E45840" data-bar-width="30" data-height="80"><canvas width="158" height="80" style="display: inline-block; width: 158px; height: 80px; vertical-align: top;"></canvas></div>
                                <ul class="list-inline text-muted axis">
                                    <li style="width: 30px; margin-right: 2px;">Que</li><li style="width: 30px; margin-right: 2px;">Ans</li><li style="width: 30px; margin-right: 2px;">Com</li><li style="width: 30px; margin-right: 2px;">UA</li><li style="width: 30px; margin-right: 2px;">US</li>
                                </ul></div>
                            <div class="acti-indicators" style="float: none; width: 100%;">
                                <ul>
                                    <li><i class="fa fa-circle text-info" style="color:#233445"></i> Questions <span>41</span></li>
                                    <li><i class="fa fa-circle text-info" style="color:#3fcf7f"></i> Answers <span>242</span></li>
                                    <li><i class="fa fa-circle text-info" style="color:#FF5F5F"></i> Comments <span>14</span></li>
                                    <li><i class="fa fa-circle text-info" style="color:#13C4A5"></i> Unanswered <span>9</span></li>
                                    <li><i class="fa fa-circle text-info" style="color:#F4C414"></i> Unselected <span>39</span></li>
                                </ul>
                            </div></div>
                    </div>
                </div>
                <div class="widget cs_site_activity"></div>



            </div>




        </div>


        <div class="col-lg-12" style="padding-top: 50px">
            <h3 class="bottom-notice" style="color: #185a66;">Looking for more? Browse the
                <a href="/questions">complete list of questions</a>, or
                <a href="/tags">popular tags</a>. Help us answer
                <a href="/unanswered">unanswered questions</a>.
            </h3>
            <!-- END qa-q-list -->
        </div>
    </div>

    </div>

</div>

</body>
</html>

<div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <h3>Login or Register</h3>
                <p class="login-desc">Get access to your account and question</p>
                <div class="social-logins">
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <form id="loginform" role="form" action="" method="post">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                <input type="text" class="form-control" id="qa-userid" name="emailhandle" placeholder="Email or Username">
                            </div>
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-key"></i></span>
                                <input type="password" class="form-control" id="qa-password" name="password" placeholder="Password">
                            </div>

                            <label class="inline">
                                <input type="checkbox" name="remember" id="qa-rememberme" value="1"> Remember									</label>
                            <input type="hidden" name="code" value="0-1488911071-aac1367d2406bc41596c558ccf3bbd0078db4182">
                            <input type="submit" value="Login" id="qa-login" name="dologin" class="btn btn-primary btn-large btn-block">
                        </form>
                    </div>
                    <div class="col-sm-6">
                        <form id="loginform" role="form" action="./register?to=" method="post">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                <input type="text" class="form-control" id="qa-userid" name="handle" placeholder="Username">
                            </div>
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-key"></i></span>
                                <input type="password" class="form-control" id="qa-password" name="password" placeholder="Password">
                            </div>
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                                <input type="text" id="email" class="form-control" name="email" placeholder="Email">
                            </div>

                            <input type="hidden" name="code" value="0-1488911071-3c0a8a9197e86212a6ed18e645a08cecc9fbdc58">
                            <input type="submit" value="Register" id="qa-register" name="doregister" class="btn btn-primary btn-block">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>



</footer>
</div>

