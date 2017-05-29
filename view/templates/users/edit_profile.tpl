<title>Edit {$user['username']}'s Profile</title>
{include file="common/messages.tpl"}
{include file="common/profile_common.tpl"}

        <div class="panel panel-default">

            <div class="qa-part-form-profile">
                <form name="save" method="post" action= "{$BASE_URL}controller/actions/users/edit_profile.php" enctype="multipart/form-data">
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
                                <input name="avatar" type="radio" value="" checked="" class="qa-form-wide-radio">
                                <span style="margin:2px 0; display:inline-block;">
                                    <img src="{$AVATAR}" width="32" height="32" class="qa-avatar-image" alt="">
                                </span>
                                Default
                                <br>
                                <input name="avatar" type="radio" value="uploaded" class="qa-form-wide-radio">
                                <input name="file" type="file">
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
                <form method="post" action="{$BASE_URL}controller/actions/users/change_pwd.php">
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