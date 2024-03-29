<title>Moderator's Page</title>
{include file="common/messages.tpl"}
{include file="common/profile_common.tpl"}

        <div class="panel panel-default">

            <div class="about-me widget">
                
                <div class="col-sm-12">
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
                </div>

                <div class="table-responsive col-md-12">
                <table id="users" class="table table-bordered table-responsive">
                    <tbody>
                    <th>Username</th>
                    <th>Role</th>
                    <th>Email</th>

                    <th style="text-align: center">Info</th>
                    <th style="text-align: center">Warn</th>

                    {foreach $users as $user}
                        <tr class="usersTable" id={$user['userid']}>
                            <td>{$user['username']}</td>
                            <td id="usrRole">{$user['rolename']}</td>
                            <td>{$user['email']}</td>

                            <td style="text-align: center">
                                <a <span class="glyphicon glyphicon-info-sign" href={profileUrl($user['userid'])}></span></a>
                            </td>

                            <td id="warnUsr" style="text-align: center">
                                <button id="triggerModal" type="button" class="btn-default btn-xs" data-toggle="modal" data-target="#warnMsgModal" style="font-size: 15px">
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
                        </tr>
                    {/foreach}

                    </tbody>
                </table>
                </div>

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

                <div class="col-sm-12">
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
                </div>

                <div class="table-responsive col-md-12">
                <table id="quests" class="table table-bordered table-responsive">
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
                                    <button type="submit" class="btn-default btn-xs" style="font-size: 15px;">
                                        <i class="glyphicon glyphicon-remove-circle"></i>
                                    </button>
                                </td>
                            </form>
                        </tr>
                    {/foreach}

                    </tbody>
                </table>
                </div>

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