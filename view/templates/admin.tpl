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
                    <h2><strong>{$user['fullname']}</strong></h2>
                    <div class="media-body">
                        <hr>
                        <h3><strong>About</strong></h3>
                        <p>{$user['about']}</p>
                        <hr>
                        <h3><strong>Email</strong></h3>
                        <p>{$user['email']}</p>
                        <hr>
                        <h3><strong>Location</strong></h3>
                        <p>{$user['location']}</p>
                        <hr>
                        <h3><strong>Created at</strong></h3>
                        <p>{$user['created_at']}</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="col-lg-9 col-md-9 col-sm-12 col-xs-12">
        <div class="panel panel-default">
            <div class="panel-body">
                    <span>
                        <h1 class="panel-title pull-left" style="font-size:30px;"> {$user['username']} <small>{$user['role']}</small> <i class="fa fa-check text-success" aria-hidden="true" data-toggle="tooltip" data-placement="bottom" title="John Doe is sharing with you"></i></h1>
                    </span>
                <br><br>
                <div class="user-activity-count clearfix">
                    <div class="points">
                        {$user['count_votes_rating_received']}
                        <span>points</span>
                    </div>
                    <div class="counts">
                        <div class="q-counts">
                            <span>{$user['count_questions']}</span>
                            Questions
                        </div>
                        <div class="a-counts">
                            <span>{$user['count_answers']}</span>
                            Answers
                        </div>
                        <div class="c-counts">
                            <span>0</span>
                            Comments
                        </div>
                    </div>

                </div>
            </div>
        </div>

        <div class="panel panel-default">

            <div class="about-me widget">
                <h3 style="padding-left: 10px">Search For Users</h3>
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
                    <th>Role</th>
                    <th>Email</th>

                    <th>Info</th>
                    <th>Warn</th>
                    <th>Ban</th>

                    {foreach $users as $user}
                        <tr id="userid">
                            <td id="xixa">{$user['username']}</td>
                            <td>{$user['roleid']}</td>
                            <td>{$user['email']}</td>

                            <td>
                                <a <span class="fa fa-info" href={profileUrl($user['userid'])}></span></a>
                            </td>

                            <td>
                                <a <button class="fa fa-warning" href="#"></button></a>
                            </td>

                            <td>
                                <a <button class="fa fa-ban" href="#"></button></a>
                            </td>

                        </tr>
                    {/foreach}

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

            <div class="about-me widget">

                <h3 style="padding-left: 10px">Search For Questions</h3>
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
                    <th>Title</th>
                    <th>Author</th>

                    <th>Info</th>
                    <th>Delete</th>

                    {foreach $questions as $question}
                        <tr id={$question['publicationid']}>
                            <td>{$question['title']}</td>
                            <td>{$question['username']}</td>

                            <td>
                                <a <span class="fa fa-info" href={questionUrl($question['publicationid'])}></span></a>
                            </td>
                            <td>
                                <a <button class="fa fa-ban"></button></a>
                            </td>
                        </tr>
                    {/foreach}

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
            <h3 style="padding-left: 10px">Status</h3>
            <canvas id="siteStats" width="350" height="300" style="padding-left: 10px; display: inline-block">
            </canvas>
            <canvas id="userStats" width="350" height="300" style="padding-left: 10px; display: inline-block">
            </canvas>
        </div>

    </div>
</div>