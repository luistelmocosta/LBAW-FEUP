<?php /* Smarty version Smarty-3.1.15, created on 2017-03-06 16:57:20
         compiled from "../templates/account.tpl" */ ?>
<?php /*%%SmartyHeaderCode:208128061258bd86e0c51107-32747420%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'e2241e3b0d22bf3a2693c74afb32dd5a55cb2b2a' => 
    array (
      0 => '../templates/account.tpl',
      1 => 1488815077,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '208128061258bd86e0c51107-32747420',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_58bd86e149e609_19434876',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_58bd86e149e609_19434876')) {function content_58bd86e149e609_19434876($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('../common/header_log.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<div id="ajax-item">
    <div id="site-body" class="container">
        <div class="clearfix qa-main">
            <div class="col-sm-8 list-c">
                <h1 class="page-title">
                    My account
                </h1>
                <section id="content" class="content-sidebar user-cols">

                    <div class="user-header">
                        <div class="user-header-inner clearfix">
                            <div class="user-thumb">
                                <a href="./user/lbaw1641"><img src="http://www.gravatar.com/avatar/8b21c0ba9bf921fa9aecfbfa62e26e08?s=150"></a>
                            </div>
                            <div class="user-name-detail">
                                <h3>lbaw1641<small class="block m-t-mini">Registered user</small>
                                </h3>


                            </div>
                            <div class="user-personal-links clearfix">
                            </div>
                            <div class="qa-nav-sub">
                                <ul class="qa-nav-sub-list">
                                    <li class="qa-nav-sub-item qa-nav-sub-profile">
                                        <a href="./user/lbaw1641" class=" qa-nav-sub-link">User lbaw1641</a>
                                    </li>
                                    <li class="qa-nav-sub-item qa-nav-sub-account">
                                        <a href="./account" class=" qa-nav-sub-link qa-nav-sub-selected">My account</a>
                                    </li>
                                    <li class="qa-nav-sub-item qa-nav-sub-favorites">
                                        <a href="./favorites" class=" qa-nav-sub-link">My favorites</a>
                                    </li>
                                    <li class="qa-nav-sub-item qa-nav-sub-wall">
                                        <a href="./user/lbaw1641/wall" class=" qa-nav-sub-link">Wall</a>
                                    </li>
                                    <li class="qa-nav-sub-item qa-nav-sub-activity">
                                        <a href="./user/lbaw1641/activity" class=" qa-nav-sub-link">Recent activity</a>
                                    </li>
                                    <li class="qa-nav-sub-item qa-nav-sub-questions">
                                        <a href="./user/lbaw1641/questions" class=" qa-nav-sub-link">All questions</a>
                                    </li>
                                    <li class="qa-nav-sub-item qa-nav-sub-answers">
                                        <a href="./user/lbaw1641/answers" class=" qa-nav-sub-link">All answers</a>
                                    </li>
                                </ul>
                                <div class="qa-nav-sub-clear">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="qa-part-form-profile">
                        <form enctype="multipart/form-data" method="post" action="./account">
                            <table class="qa-form-wide-table">
                                <tbody><tr>
                                    <td class="qa-form-wide-label">
                                        Member for:
                                    </td>
                                    <td class="qa-form-wide-data">
                                        <span class="qa-form-wide-static">19 hours</span>
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
                                        <input name="avatar" type="radio" value="" checked="" class="qa-form-wide-radio"> <span style="margin:2px 0; display:inline-block;"><img src="./?qa=image&amp;qa_blobid=11054542722540118350&amp;qa_size=32" width="32" height="32" class="qa-avatar-image" alt=""></span> Default
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
                            <input type="hidden" name="code" value="1-1488473870-cda6797ba37cef1fc76dc982749c4208b3de5ead">
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
                            <input type="hidden" name="code" value="1-1488473870-62f54a48648d92884ef0985ded5d30eaf5da50ce">
                        </form>
                    </div>
                </section>
            </div>
            <div class="col-sm-4 side-c">
                <div class="qa-sidepanel">
                    <div id="right-position">
                        <div class="widget cs_site_status">												<h3 class="widget-title">Site Status</h3>
                            <div class="ra-site-status-widget">
                                <div class="site-status-inner clearfix"><div class="bar-float"><div class="sparkline" data-type="bar" data-bar-color="#E45840" data-bar-width="30" data-height="80"><canvas width="158" height="80" style="display: inline-block; width: 158px; height: 80px; vertical-align: top;"></canvas></div>
                                        <ul class="list-inline text-muted axis">
                                            <li style="width: 30px; margin-right: 2px;">Que</li><li style="width: 30px; margin-right: 2px;">Ans</li><li style="width: 30px; margin-right: 2px;">Com</li><li style="width: 30px; margin-right: 2px;">UA</li><li style="width: 30px; margin-right: 2px;">US</li>
                                        </ul></div>
                                    <div class="acti-indicators">
                                        <ul>
                                            <li><i class="fa fa-circle text-info" style="color:#233445"></i> Questions <span>40</span></li>
                                            <li><i class="fa fa-circle text-info" style="color:#3fcf7f"></i> Answers <span>242</span></li>
                                            <li><i class="fa fa-circle text-info" style="color:#FF5F5F"></i> Comments <span>14</span></li>
                                            <li><i class="fa fa-circle text-info" style="color:#13C4A5"></i> Unanswered <span>8</span></li>
                                            <li><i class="fa fa-circle text-info" style="color:#F4C414"></i> Unselected <span>38</span></li>
                                        </ul>
                                    </div></div>
                            </div>
                        </div>
                        <div class="widget cs_tags">												<h3 class="widget-title">Tags<a href="./tags">View all</a></h3>
                            <div class="ra-tags-widget clearfix">
                                <a href="./tag/cleanstrap" class="widget-tag">cleanstrap<span>23</span></a>
                                <a href="./tag/cleanstrap+theme" class="widget-tag">cleanstrap theme<span>14</span></a>
                                <a href="./tag/question2answer+theme" class="widget-tag">question2answer theme<span>10</span></a>
                                <a href="./tag/q2a+theme" class="widget-tag">q2a theme<span>9</span></a>
                                <a href="./tag/cleanstrap+options" class="widget-tag">cleanstrap options<span>5</span></a>
                                <a href="./tag/cleanstrap+widgets" class="widget-tag">cleanstrap widgets<span>4</span></a>
                                <a href="./tag/development" class="widget-tag">development<span>3</span></a>
                                <a href="./tag/widgets" class="widget-tag">widgets<span>3</span></a>
                                <a href="./tag/install" class="widget-tag">install<span>2</span></a>
                                <a href="./tag/votes" class="widget-tag">votes<span>2</span></a>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <?php echo $_smarty_tpl->getSubTemplate ('../common/footer.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

    </div>
</div><?php }} ?>
