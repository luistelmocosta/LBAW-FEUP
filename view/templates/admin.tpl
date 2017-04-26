<title>Admin's Page</title>
<div style="padding-top:30px;"> </div>
<div id="site-body" class="container">
    <div class="col-lg-3 col-md-3 hidden-sm hidden-xs">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="media">
                    <div align="center">
                        <img class="thumbnail img-responsive" src="https://lut.im/7JCpw12uUT/mY0Mb78SvSIcjvkf.png" width="300px" height="300px">
                    </div>
                    <h2><strong>John Doe</strong></h2>
                    <div class="media-body">
                        <hr>
                        <h3><strong>Bio</strong></h3>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur vel gravida metus, non ultrices sapien. Morbi odio metus, dapibus non nibh id amet.</p>
                        <hr>
                        <h3><strong>Location</strong></h3>
                        <p>Earth</p>
                        <hr>
                        <h3><strong>Gender</strong></h3>
                        <p>Unknown</p>
                        <hr>
                        <h3><strong>Birthday</strong></h3>
                        <p>January 01 1901</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12">
        <div class="panel panel-default">
            <div class="panel-body">
                    <span>
                        <h1 class="panel-title pull-left" style="font-size:30px;">John Doe <small>example@pods.tld</small> <i class="fa fa-check text-success" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="John Doe is sharing with you"></i></h1>

                    </span>
                <br><br>
                <div class="user-activity-count clearfix">
                    <div class="points">
                        120
                        <span>points</span>
                    </div>
                    <div class="counts">
                        <div class="a-counts">
                            <span>0</span>
                            Answers
                        </div>
                        <div class="q-counts">
                            <span>0</span>
                            Questions
                        </div>
                        <div class="c-counts">
                            <span>0</span>
                            Comments
                        </div>
                    </div>

                    <div class="bar-chart">
                        <div class="sparkline" data-type="bar" data-bar-color="#FDAB0C" data-bar-width="20" data-height="28"><canvas width="64" height="28" style="display: inline-block; width: 64px; height: 28px; vertical-align: top;"></canvas></div>
                        <ul class="list-inline text-muted axis"><li style="width: 20px; margin-right: 2px;">A</li><li style="width: 20px; margin-right: 2px;">Q</li><li style="width: 20px; margin-right: 2px;">C</li></ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="panel panel-default">

            <div class="about-me widget">
                <h3 style="padding-left: 5px">Search For User</h3>
                <form class = "navbar-form navbar-left" role = "search" method = "post" action = "" style="display: inline">

                    <div class="input-group stylish-input-group">
                        <input type="text" class="form-control"  placeholder="Search" >
                        <span class="input-group-addon">
                        <button type="submit">
                            <span class="glyphicon glyphicon-search"></span>
                        </button>
                    </span>
                    </div>
                </form>

                <table class="table table-bordered table-responsive table-compact table-collapsing">
                    <tbody>
                    <th>Username</th>
                    <th>Permission Level</th>

                    <th>Email</th>

                    <th>Info</th>
                    <th>Ban</th>
                    <th>Warn</th>


                    <tr id="1">
                        <td>lbaw1641</td>
                        <td>Admin</td>

                        <td>luistelmocosta@gmail.com</td>

                        <td>
                            <a <span class="fa fa-info" onClick="loadMoreInfoModal(1)" data-toggle="modal" data-target="#moreInfo">

                                        </span></a>
                        </td>

                        <td>
                            <a <button class="fa fa-ban" onClick="loadMoreInfoModal(1)" data-toggle="modal" data-target="#moreInfo">

                            </button></a>
                        </td>
                        <td>
                            <a <button class="fa fa-warning" onClick="loadMoreInfoModal(1)" data-toggle="modal" data-target="#moreInfo">

                            </button></a>
                        </td>

                    </tr>

                    </tbody>
                </table>

                <ul class="pagination clearfix">
                    <li class="qa-page-links-item">
                        <span class="qa-page-selected">1</span>
                    </li>
                    <li class="qa-page-links-item">
                        <a href="" class="qa-page-link">2</a>
                    </li>
                    <li class="qa-page-links-item">
                        <a href="" class="qa-page-next">next »</a>
                    </li>
                </ul>

            </div>

        </div>

        <div class="panel panel-default">

            <div class="user-cols-right">

                <div class="user-qac-list">
                    <div id="user-content-position">
                        <div class="widget cs_user_posts">												<h3 style="padding-left: 10px" class="widget-title user-post-title">John Doe's Questions<a class="see-all" href="#">Show all</a></h3>
                            <div class="ra-ua-widget">

                                <div class="question-summary narrow">

                                    <div class="col-md-12">
                                        <div class="stat" style = "float: right">
                                            <div class="votes">
                                                <div class="mini-counts"><span title="7 votes">7</span></div>
                                                <div>votes</div>
                                            </div>
                                            <div class="status answered-accepted" title="one of the answers was accepted as the correct answer">
                                                <div class="mini-counts"><span title="1 answer">1</span></div>
                                                <div>answer</div>
                                            </div>
                                            <div class="views">
                                                <div class="mini-counts"><span title="140 views">140</span></div>
                                                <div>views</div>
                                            </div>
                                        </div>

                                        <div class="summary" style="padding-left: 10px">
                                            <h3>
                                                <a href="" class="question-hyperlink" style="font-size: 15px; line-height: 1.4; margin-bottom: .5em;">
                                                    How do I implement a class in C++?
                                                </a>
                                            </h3>
                                        </div>


                                        <div class = "statistics col-sm-12 text-right" style="float: right">
        <span>
            <i class = "glyphicon glyphicon-time"></i>
            <span class="question-updated-at">10 min ago</span>
        </span>
                                            <span>
            <i class = "glyphicon glyphicon-comment"></i>
            <span class="question-answers">1</span>
        </span>
                                        </div>
                                    </div>

                                </div>

                                <div class="question-summary narrow">

                                    <div class="col-md-12">
                                        <div class="stat" style = "float: right">
                                            <div class="votes">
                                                <div class="mini-counts"><span title="7 votes">7</span></div>
                                                <div>votes</div>
                                            </div>
                                            <div class="status answered-accepted" title="one of the answers was accepted as the correct answer">
                                                <div class="mini-counts"><span title="1 answer">1</span></div>
                                                <div>answer</div>
                                            </div>
                                            <div class="views">
                                                <div class="mini-counts"><span title="140 views">140</span></div>
                                                <div>views</div>
                                            </div>
                                        </div>

                                        <div class="summary" style="padding-left: 10px">
                                            <h3>
                                                <a href="" class="question-hyperlink" style="font-size: 15px; line-height: 1.4; margin-bottom: .5em;">
                                                    How do I implement a class in C++?
                                                </a>
                                            </h3>
                                        </div>


                                        <div class = "statistics col-sm-12 text-right" style="float: right">
        <span>
            <i class = "glyphicon glyphicon-time"></i>
            <span class="question-updated-at">10 min ago</span>
        </span>
                                            <span>
            <i class = "glyphicon glyphicon-comment"></i>
            <span class="question-answers">1</span>
        </span>
                                        </div>
                                    </div>

                                </div>

                            </div>
                        </div>
                        <div class="widget cs_user_posts">												<h3 style="padding-left: 10px" class="widget-title user-post-title">John Doe's Answers<a class="see-all" href="#">Show all</a></h3>
                            <div class="ra-ua-widget">
                                <ul class="question-list users-post-widget post-type-A"><li class="no-post-found">No Answers posted yet! </li></ul>
                            </div>
                        </div>
                        <div class="widget cs_user_posts">												<h3 style="padding-left: 10px" class="widget-title user-post-title">John Doe's Comments<a class="see-all" href="#">Show all</a></h3>
                            <div class="ra-ua-widget">
                                <ul class="question-list users-post-widget post-type-C"><li class="no-post-found">No Comments posted yet! </li></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>