<title>Edit {$user['username']}'s Profile</title>
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

            <div class="qa-part-form-profile">
                <form name="save" method="post" action= "{$BASE_URL}controller/actions/users/edit_profile.php">
                    <table class="qa-form-wide-table">
                        <tbody>
                        <tr>
                            <td class="qa-form-wide-label">
                                Full name:
                            </td>
                            <td class="qa-form-wide-data">
                                <input name="fullname" type="text" value="" class="qa-form-wide-text">
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-wide-label">
                                Email:
                            </td>
                            <td class="qa-form-wide-data">
                                <input name="email" type="text" value="" class="qa-form-wide-text">
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-wide-label">
                                Location:
                            </td>
                            <td class="qa-form-wide-data">
                                <input name="location" type="text" value="" class="qa-form-wide-text">
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-wide-label" style="vertical-align:top;">
                                Avatar:
                            </td>
                            <td class="qa-form-wide-data">
                                <input name="avatar" type="radio" value="" checked="" class="qa-form-wide-radio"> <span style="margin:2px 0; display:inline-block;"><img src="https://lut.im/7JCpw12uUT/mY0Mb78SvSIcjvkf.png" width="32" height="32" class="qa-avatar-image" alt=""></span> Default
                                <br>
                                <input name="avatar" type="radio" value="uploaded" class="qa-form-wide-radio"> <input name="file" type="file">
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-wide-label" style="vertical-align:top;">
                                About:
                            </td>
                            <td class="qa-form-wide-data">
                                <textarea name="about" rows="8" cols="40" class="qa-form-wide-text"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="qa-form-wide-buttons">
                                <input value="save" title="" type="submit" class="qa-form-wide-button qa-form-wide-button-save">
                            </td>
                        </tr>
                        </tbody></table>
                </form>
            </div>
        </div>

            <div class="qa-part-form-password">
                <h2>Change Password</h2>
                <form method="post" action="./account">
                    <table class="qa-form-wide-table">
                        <tbody><tr>
                            <td class="qa-form-wide-label">
                                Old password:
                            </td>
                            <td class="qa-form-wide-data">
                                <input name="oldpassword" type="password" value="" class="qa-form-wide-text">
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-wide-label">
                                New password:
                            </td>
                            <td class="qa-form-wide-data">
                                <input name="newpassword1" type="password" value="" class="qa-form-wide-text">
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-wide-label">
                                Retype new password:
                            </td>
                            <td class="qa-form-wide-data">
                                <input name="newpassword2" type="password" value="" class="qa-form-wide-text">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="qa-form-wide-buttons">
                                <input value="Change Password" title="" type="submit" class="qa-form-wide-button qa-form-wide-button-change">
                            </td>
                        </tr>
                        </tbody></table>
                    </form>
            </div>

        </div>
    </div>

</div>