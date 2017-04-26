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

            <div class="qa-part-form-profile">
                <form enctype="multipart/form-data" method="post" action="./account">
                    <table class="qa-form-wide-table">
                        <tbody><tr>
                            <td class="qa-form-wide-label">
                                Member for:
                            </td>
                            <td class="qa-form-wide-data">
                                <span class="qa-form-wide-static">1 week</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-wide-label">
                                Type:
                            </td>
                            <td class="qa-form-wide-data">
                                <span class="qa-form-wide-static">Registered user</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-wide-label">
                                Username:
                            </td>
                            <td class="qa-form-wide-data">
                                <input name="handle" type="text" value="lbaw1641" class="qa-form-wide-text">
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-wide-label">
                                Email:
                            </td>
                            <td class="qa-form-wide-data">
                                <input name="email" type="text" value="luistelmocosta@gmail.com" class="qa-form-wide-text">
                                <span class="qa-form-wide-error">Please <a href="./confirm">confirm</a></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-wide-label">
                                Private messages:
                            </td>
                            <td class="qa-form-wide-data">
                                <input name="messages" type="checkbox" value="1" checked="" class="qa-form-wide-checkbox">
                                <span class="qa-form-wide-note">Allow users to email you (without seeing your address)</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-wide-label">
                                Wall posts:
                            </td>
                            <td class="qa-form-wide-data">
                                <input name="wall" type="checkbox" value="1" checked="" class="qa-form-wide-checkbox">
                                <span class="qa-form-wide-note">Allow users to post on your wall (you will also be emailed)</span>
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-wide-label" style="vertical-align:top;">
                                Avatar:
                            </td>
                            <td class="qa-form-wide-data">
                                <input name="avatar" type="radio" value="" checked="" class="qa-form-wide-radio"> <span style="margin:2px 0; display:inline-block;"><img src="?qa=image&amp;qa_blobid=11054542722540118350&amp;qa_size=32" width="32" height="32" class="qa-avatar-image" alt=""></span> Default
                                <br>
                                <input name="avatar" type="radio" value="gravatar" class="qa-form-wide-radio"> <span style="margin:2px 0; display:inline-block;"><img src="http://www.gravatar.com/avatar/8b21c0ba9bf921fa9aecfbfa62e26e08?s=32" width="32" height="32" class="qa-avatar-image" alt=""> Show my <a href="http://www.gravatar.com/" target="_blank">Gravatar</a></span>
                                <br>
                                <input name="avatar" type="radio" value="uploaded" class="qa-form-wide-radio"> <input name="file" type="file">
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-wide-label">
                                Full name:
                            </td>
                            <td class="qa-form-wide-data">
                                <input name="field_1" type="text" value="" class="qa-form-wide-text">
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-wide-label">
                                Location:
                            </td>
                            <td class="qa-form-wide-data">
                                <input name="field_2" type="text" value="" class="qa-form-wide-text">
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-wide-label">
                                Website:
                            </td>
                            <td class="qa-form-wide-data">
                                <input name="field_3" type="text" value="" class="qa-form-wide-text">
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-wide-label" style="vertical-align:top;">
                                About:
                            </td>
                            <td class="qa-form-wide-data">
                                <textarea name="field_4" rows="8" cols="40" class="qa-form-wide-text"></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="3" class="qa-form-wide-buttons">
                                <input onclick="qa_show_waiting_after(this, false);" value="Save Profile" title="" type="submit" class="qa-form-wide-button qa-form-wide-button-save">
                            </td>
                        </tr>
                        </tbody></table>
                    <input type="hidden" name="dosaveprofile" value="1">
                    <input type="hidden" name="code" value="1-1489607116-aaa1b326f97b55790326ff31ee4288b478fcf6e9">
                </form>
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
                    <input type="hidden" name="dochangepassword" value="1">
                    <input type="hidden" name="code" value="1-1489606843-ffc685c24609fa23f087f8ed030411a30e18486c">
                </form>
            </div>

        </div>
    </div>

</div>
</div>
</div>
</div>
