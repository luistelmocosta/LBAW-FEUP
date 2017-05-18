<title>Admin's Page</title>
{include file="common/messages.tpl"}
<div id="site-body" class="container">
    <div class="col-lg-3 col-md-3 hidden-sm hidden-xs">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="media">
                    <div align="center">
                        <img class="thumbnail img-responsive" src="{$AVATAR}" width="300px" height="300px">
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

                <table id="users" class="table table-bordered table-responsive table-compact table-collapsing">
                    <tbody>
                    <th>Username</th>
                    <th>Role</th>
                    <th>Email</th>

                    <th style="text-align: center">Info</th>
                    <th style="text-align: center">Warn</th>
                    <th style="text-align: center">Ban</th>
                    <th style="text-align: center">Promote</th>

                    {foreach $users as $user}
                        <tr class="usersTable" id={$user['userid']}>
                            <td>{$user['username']}</td>
                            <td id="usrRole">{$user['name']}</td>
                            <td>{$user['email']}</td>

                            <td style="text-align: center">
                                <a <span class="glyphicon glyphicon-info-sign" href={profileUrl($user['userid'])}></span></a>
                            </td>

                            <td id="warnUsr" style="text-align: center">
                                <button id="triggerModal" type="button" class="btn-default btn-sm" data-toggle="modal" data-target="#warnMsgModal" style="font-size: 15px">
                                    <i class="glyphicon glyphicon-warning-sign"></i>
                                </button>

                                <div class="modal fade" id="warnMsgModal" role="dialog">
                                    <div class="modal-dialog modal-md">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                                <h4 class="modal-title">Warning Message</h4>
                                            </div>
                                            <form id="warnUsr" name="wrnUsr" method="post" action="">
                                                <div class="modal-body">
                                                    <textarea id="warnMsg" name="msg"></textarea>
                                                </div>
                                                <div class="modal-footer">
                                                    <button id="subBtn" type="submit" class="btn-default btn-xs">Warn</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>

                            </td>

                            <form name="banUsr" method="post" action="">
                                <td id="banUsr" style="text-align: center">
                                    <label class="switch">
                                        <input id="ban" type="checkbox" data-toggle="modal" data-target="#banMsgModal">
                                        <div class="slider round"></div>
                                    </label>
                            </form>

                            <div class="modal fade" id="banMsgModal" role="dialog">
                                <div class="modal-dialog modal-md">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                            <h4 class="modal-title">Ban Message</h4>
                                        </div>
                                        <form id="banUsr" name="bnUsr" method="post" action="">
                                            <div class="modal-body">
                                                <textarea id="banMsg" name="msg"></textarea>
                                            </div>
                                            <div class="modal-footer">
                                                <button id="subBtn" type="submit" class="btn-default btn-xs">Ban</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>

                            </td>

                            <form name="promUsr" method="post" action="{$BASE_URL}controller/api/admin/prom_user.php">
                                <td id="promUsr" style="text-align: center">
                                    <label id="permLabel"></label>
                                    <div id="slider-range"></div>
                                </td>
                            </form>

                        </tr>
                    {/foreach}

                    </tbody>
                </table>

                <ul class="pagination clearfix">
                    <li class="qa-page-links-item">
                        <a href="?upage=1" class="qa-page-next">«« 1</a>
                    </li>
                    <li class="qa-page-links-item">
                        <a href="?upage={$upage-1}&qpage={$qpage}" class="qa-page-link">« back</a>
                    </li>
                    <li class="qa-page-links-item">
                        <a href="#" class="qa-page-selected qa-page-link">{$upage}</a>
                    </li>
                    <li class="qa-page-links-item">
                        <a href="?upage={$upage+1}&qpage={$qpage}" class="qa-page-link">{$upage+1}</a>
                    </li>
                    <li class="qa-page-links-item">
                        <a href="?upage={$upage+2}&qpage={$qpage}" class="qa-page-link">{$upage+2}</a>
                    </li>
                    <li class="qa-page-links-item" >
                        <a href="?upage={$upage+1}&qpage={$qpage}" class="qa-page-next">next »</a>
                    </li>
                    <li class="qa-page-links-item">
                        <a href="?upage={$upages}&qpage={$qpage}" class="qa-page-link">{$upages} »»</a>
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

                <table id="quests" class="table table-bordered table-responsive table-compact table-collapsing">
                    <tbody>
                    <th>Title</th>
                    <th>Author</th>

                    <th style="text-align: center">Info</th>
                    <th style="text-align: center">Delete</th>

                    {foreach $questions as $question}
                        <tr class="questTable" id={$question['publicationid']}>
                            <td>{$question['title']}</td>
                            <td>{$question['username']}</td>
                            <td style="text-align: center">
                                <a <span class="glyphicon glyphicon-info-sign" href={questionUrl($question['publicationid'])}></span></a>
                            </td>
                            <form name="delQuest" method="post" action="{$BASE_URL}controller/api/admin/delete_publication.php">
                                <td id="delQuest" style="text-align: center">
                                    <button type="submit" class="btn-default btn-sm" style="font-size: 15px;">
                                        <i class="glyphicon glyphicon-remove-circle"></i>
                                    </button>
                                </td>
                            </form>
                        </tr>
                    {/foreach}

                    </tbody>
                </table>

                <ul class="pagination clearfix">
                    <li class="qa-page-links-item">
                        <a href="?upage={$upage}&qpage=1" class="qa-page-next">«« 1</a>
                    </li>
                    <li class="qa-page-links-item">
                        <a href="?upage={$upage}&qpage={$qpage-1}" class="qa-page-link">« back</a>
                    </li>
                    <li class="qa-page-links-item">
                        <a href="#" class="qa-page-selected qa-page-link">{$qpage}</a>
                    </li>
                    <li class="qa-page-links-item">
                        <a href="?upage={$upage}&qpage={$qpage+1}" class="qa-page-link">{$qpage+1}</a>
                    </li>
                    <li class="qa-page-links-item">
                        <a href="?upage={$upage}&qpage={$qpage+2}" class="qa-page-link">{$qpage+2}</a>
                    </li>
                    <li class="qa-page-links-item" >
                        <a href="?upage={$upage}&qpage={$qpage+1}" class="qa-page-next">next »</a>
                    </li>
                    <li class="qa-page-links-item">
                        <a href="?upage={$upage}&qpage={$qpages}" class="qa-page-link">{$qpages} »»</a>
                    </li>
                </ul>
            </div>

        </div>


        <div class="panel panel-default">
            <h3 style="padding-left: 10px">Create new category</h3>
            <form class = "navbar-form" method = "post" action = "{$BASE_URL}controller/actions/admin/create_category.php">
                <div class="input-group stylish-input-group">
                    <input type="text" class="form-control" name="newCat" placeholder="New category" >
                    <span class="input-group-addon">
                            <button type="submit">
                                <span class="glyphicon glyphicon-plus"></span>
                            </button>
                        </span>
                </div>
            </form>
        </div>


        <div class="panel panel-default">
            <h3 style="padding-left: 10px">Status</h3>
            <canvas id="siteStats" width="250" height="300" style="padding-left: 10px; display: inline-block">
            </canvas>
            <canvas id="usersStats" width="250" height="300" style="padding-left: 10px; display: inline-block">
            </canvas>
            <canvas id="behaviourStats" width="250" height="300" style="padding-left: 10px; display: inline-block">
            </canvas>
        </div>

    </div>
</div>

{HTML::script('admin.js')}
