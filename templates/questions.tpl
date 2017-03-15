<body id="site-body" class="container">
<div class="clearfix qa-main">
    <div class="home-left-inner">




        <div class="col-md-8"">
        <h1>
            All Questions
        </h1>

        <br>


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


            <ul class="pagination clearfix">
                <li class="qa-page-links-item">
                    <span class="qa-page-selected">1</span>
                </li>
                <li class="qa-page-links-item">
                    <a href="./questions?start=20" class="qa-page-link">2</a>
                </li>
                <li class="qa-page-links-item">
                    <a href="./questions?start=40" class="qa-page-link">3</a>
                </li>
                <li class="qa-page-links-item">
                    <a href="./questions?start=20" class="qa-page-next">next »</a>
                </li>
            </ul>

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

</div>





</body>
</html>




</footer>