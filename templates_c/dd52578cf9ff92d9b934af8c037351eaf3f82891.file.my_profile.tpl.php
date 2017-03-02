<?php /* Smarty version Smarty-3.1.15, created on 2017-03-02 20:59:22
         compiled from "../templates/my_profile.tpl" */ ?>
<?php /*%%SmartyHeaderCode:159783394558b845f4c62048-61339356%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'dd52578cf9ff92d9b934af8c037351eaf3f82891' => 
    array (
      0 => '../templates/my_profile.tpl',
      1 => 1488484757,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '159783394558b845f4c62048-61339356',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_58b845f4c661f5_47381153',
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_58b845f4c661f5_47381153')) {function content_58b845f4c661f5_47381153($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('../common/header_log.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>


<div id="ajax-item">
    <div id="site-body" class="container">
        <div class="clearfix qa-main">
            <div class="col-sm-8 list-c">
                <div class="user-cols content-sidebar">

                    <div class="user-header">
                        <div class="user-header-inner clearfix">
                            <div class="user-thumb">
                                <a href="../user/lbaw1641"><img src="http://www.gravatar.com/avatar/8b21c0ba9bf921fa9aecfbfa62e26e08?s=150"></a>
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
                                        <a href="../user/lbaw1641" class=" qa-nav-sub-link qa-nav-sub-selected">User lbaw1641</a>
                                    </li>
                                    <li class="qa-nav-sub-item qa-nav-sub-account">
                                        <a href="../account" class=" qa-nav-sub-link">My account</a>
                                    </li>
                                    <li class="qa-nav-sub-item qa-nav-sub-favorites">
                                        <a href="../favorites" class=" qa-nav-sub-link">My favorites</a>
                                    </li>
                                    <li class="qa-nav-sub-item qa-nav-sub-wall">
                                        <a href="../user/lbaw1641/wall" class=" qa-nav-sub-link">Wall</a>
                                    </li>
                                    <li class="qa-nav-sub-item qa-nav-sub-activity">
                                        <a href="../user/lbaw1641/activity" class=" qa-nav-sub-link">Recent activity</a>
                                    </li>
                                    <li class="qa-nav-sub-item qa-nav-sub-questions">
                                        <a href="../user/lbaw1641/questions" class=" qa-nav-sub-link">All questions</a>
                                    </li>
                                    <li class="qa-nav-sub-item qa-nav-sub-answers">
                                        <a href="../user/lbaw1641/answers" class=" qa-nav-sub-link">All answers</a>
                                    </li>
                                </ul>
                                <div class="qa-nav-sub-clear">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="user-cols-right">
                        <div class="user-activity-count clearfix">
                            <div class="points">
                                100
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
                        <div class="about-me widget">
                            <h3 class="widget-title">User Profile</h3>
                            <form method="post" action="../user/lbaw1641">
                                <table class="qa-form-wide-table">
                                    <tbody id="avatar">
                                    <tr>
                                        <td class="qa-form-tall-data" colspan="3">
                                            <div class="qa-form-tall-image"><a href="../user/lbaw1641" class="qa-avatar-link"><img src="../?qa=image&amp;qa_blobid=11054542722540118350&amp;qa_size=200" width="128" height="128" class="qa-avatar-image" alt=""></a></div>
                                        </td>
                                    </tr>
                                    </tbody>
                                    <tbody><tr id="duration">
                                        <td class="qa-form-wide-label">
                                            Member for:
                                        </td>
                                        <td class="qa-form-wide-data">
                                            <span class="qa-form-wide-static">18 hours</span>
                                        </td>
                                    </tr>
                                    <tr id="level">
                                        <td class="qa-form-wide-label">
                                            Type:
                                        </td>
                                        <td class="qa-form-wide-data">
                                            <span class="qa-form-wide-static">Registered user</span>
                                        </td>
                                    </tr>
                                    <tr id="userfield-1">
                                        <td class="qa-form-wide-label">
                                            Full name:
                                        </td>
                                        <td class="qa-form-wide-data">
                                            <span class="qa-form-wide-static"></span>
                                        </td>
                                    </tr>
                                    <tr id="userfield-2">
                                        <td class="qa-form-wide-label">
                                            Location:
                                        </td>
                                        <td class="qa-form-wide-data">
                                            <span class="qa-form-wide-static"></span>
                                        </td>
                                    </tr>
                                    <tr id="userfield-3">
                                        <td class="qa-form-wide-label">
                                            Website:
                                        </td>
                                        <td class="qa-form-wide-data">
                                            <span class="qa-form-wide-static"></span>
                                        </td>
                                    </tr>
                                    <tr id="userfield-4">
                                        <td class="qa-form-wide-label" style="vertical-align:top;">
                                            About:
                                        </td>
                                        <td class="qa-form-wide-data">
                                            <span class="qa-form-wide-static"></span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" class="qa-form-wide-buttons">
                                            <input name="doaccount" value="Edit my Profile" title="" type="submit" class="qa-form-wide-button qa-form-wide-button-account">
                                        </td>
                                    </tr>
                                    </tbody></table>
                            </form>
                        </div>
                        <div class="user-qac-list">
                            <div id="user-content-position">
                                <div class="widget cs_user_activity">												<h3 class="widget-title">lbaw1641's activities</h3>
                                    <div class="ra-ua-widget">
                                        <div class="user-activities"><ul><li>No activity yet!</li></ul></div>
                                    </div>
                                </div>
                                <div class="widget cs_user_posts">												<h3 class="widget-title user-post-title">lbaw1641's Questions<a class="see-all" href="../user/lbaw1641/questions">Show all</a></h3>
                                    <div class="ra-ua-widget">
                                        <ul class="question-list users-post-widget post-type-Q"><li class="no-post-found">No Questions posted yet! </li></ul>
                                    </div>
                                </div>
                                <div class="widget cs_user_posts">												<h3 class="widget-title user-post-title">lbaw1641's Answers<a class="see-all" href="../user/lbaw1641/answers">Show all</a></h3>
                                    <div class="ra-ua-widget">
                                        <ul class="question-list users-post-widget post-type-A"><li class="no-post-found">No Answers posted yet! </li></ul>
                                    </div>
                                </div>
                                <div class="widget cs_user_posts">												<h3 class="widget-title user-post-title">lbaw1641's Comments</h3>
                                    <div class="ra-ua-widget">
                                        <ul class="question-list users-post-widget post-type-C"><li class="no-post-found">No Comments posted yet! </li></ul>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="col-sm-4 side-c">
                <div class="qa-sidepanel">
                    <div id="right-position">
                        <div class="widget cs_site_status">											<h3 class="widget-title">Site Status</h3>
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
                        <div class="widget cs_tags">											<h3 class="widget-title">Tags<a href="../tags">View all</a></h3>
                            <div class="ra-tags-widget clearfix">
                                <a href="../tag/cleanstrap" class="widget-tag">cleanstrap<span>23</span></a>
                                <a href="../tag/cleanstrap+theme" class="widget-tag">cleanstrap theme<span>14</span></a>
                                <a href="../tag/question2answer+theme" class="widget-tag">question2answer theme<span>10</span></a>
                                <a href="../tag/q2a+theme" class="widget-tag">q2a theme<span>9</span></a>
                                <a href="../tag/cleanstrap+options" class="widget-tag">cleanstrap options<span>5</span></a>
                                <a href="../tag/cleanstrap+widgets" class="widget-tag">cleanstrap widgets<span>4</span></a>
                                <a href="../tag/development" class="widget-tag">development<span>3</span></a>
                                <a href="../tag/widgets" class="widget-tag">widgets<span>3</span></a>
                                <a href="../tag/install" class="widget-tag">install<span>2</span></a>
                                <a href="../tag/votes" class="widget-tag">votes<span>2</span></a>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <?php echo $_smarty_tpl->getSubTemplate ('../common/footer.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

    </div>
</div><?php }} ?>
