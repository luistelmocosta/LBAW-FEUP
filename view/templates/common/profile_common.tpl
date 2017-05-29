<div class="site-body container">
    <div class="col-lg-3 col-md-3 hidden-sm hidden-xs">
        <div class="panel panel-default">
            <div class="panel-body">
                <div class="media">
                    <div align="center">
                        <img class="thumbnail img-responsive" src="{$avatarprof}" width="300px" height="300px">
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

                        {if $own}
                            <td colspan="3" class="qa-form-wide-buttons">
                                <a href="{$BASE_URL}controller/pages/users/edit_profile.php">
                                    <input name="doaccount" value="Edit Profile" title="" type="submit" class="qa-form-wide-button qa-form-wide-button-account">
                                </a>
                            </td>
                        {/if}
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
                            <span>{$user['count_comments']}</span>
                            Comments
                        </div>

                    </div>
                </div>
            </div>
        </div>