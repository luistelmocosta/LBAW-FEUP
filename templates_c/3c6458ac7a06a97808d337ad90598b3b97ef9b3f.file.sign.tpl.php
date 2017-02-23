<?php /* Smarty version Smarty-3.1.15, created on 2017-02-22 20:02:02
         compiled from "../templates/sign.tpl" */ ?>
<?php /*%%SmartyHeaderCode:105340444758acdbdcf064d1-38950047%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '3c6458ac7a06a97808d337ad90598b3b97ef9b3f' => 
    array (
      0 => '../templates/sign.tpl',
      1 => 1487790060,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '105340444758acdbdcf064d1-38950047',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_58acdbdd6756f4_71463523',
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_58acdbdd6756f4_71463523')) {function content_58acdbdd6756f4_71463523($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('../common/header.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>


<div class = "container">

    <div class = "col-sm-8 col-sm-offset-2">

        <!-- TABS START -->
        <ul class = "nav nav-tabs">
            <li class = "active">
                <a href = "#login" aria-controls = "login" role = "tab" data-toggle = "tab">Log In</a>
            </li>
            <li class = "active">
                <a href = "#register" aria-controls = "register" role = "tab" data-toggle = "tab">Sign Up</a>
            </li>
        </ul>
        <!-- END TABS -->

        <!-- TAB CONTENT -->
        <div class = "tab-content">

            <!-- LOGIN TAB PANEL -->
            <div id = "login" role = "tabpanel" class = "tab-pane container-white active">
                <form class = "form-horizontal" action = "" method = "post">
                    <div class = "form-group">
                        <label for = "username" class = "col-sm-3 control-label">Username</label>
                        <div class = "col-sm-8">
                            <input type = "text" name = "username" class = "form-control" placeholder = "Username" required = "" autofocus = "" autocomplete = "off">
                        </div>
                    </div>

                    <div class = "form-group">
                        <label for = "password" class = "col-sm-3 control-label">Password</label>
                        <div class = "col-sm-8">
                            <input type = "password" name = "password" class = "form-control" placeholder = "Password" required = "" autocomplete = "off">
                        </div>
                    </div>

                    <div class = "form-group">
                        <div class = "col-sm-3 col-sm-offset-3">
                            <input type = "submit" class = "btn btn-primary" value = "Log In"></button>
                        </div>
                        <div class = "col-sm-5 text-right">
                            <a href = "" class = "small" data-toggle = "modal" data-target = "#forgotPassword"> Forgot Password?</a>
                        </div>
                    </div>
                </form>
            </div>
            <!-- END LOGIN TAB PANEL -->

            <!-- REGISTER TAB PANEL -->
            <div role = "tabpanel" class = "tab-pane container-white active" id = "register">
                <form class = "form-horizontal" action = "" method = "post" enctype = "multipart/form-data">

                    <div class = "form-group">
                        <label for = "username" class = "col-sm-3 control-label">Username</label>
                        <div class = "col-sm-8">
                            <input type = "text" name = "username" class = "form-control" placeholder = "Username" required = "" autofocus = "" autocomplete = "off" value = "">
                        </div>
                    </div>

                    <div class = "form-group">
                        <label for = "email" class = "col-sm-3 control-label">Email</label>
                        <div class = "col-sm-8">
                            <input type = "email" name = "email" class = "form-control" placeholder = "Email address" required = "" autofocus = "" autocomplete = "off" value = "">
                        </div>
                    </div>

                    <div class = "form-group">
                        <label for = "password" class = "col-sm-3 control-label">Password</label>
                        <div class = "col-sm-8">
                            <input type = "password" name = "password" class = "form-control" placeholder = "Password" required = "" autocomplete = "off" value = "">
                        </div>
                    </div>

                    <div class = "form-group">
                        <label for = "verify_password" class = "col-sm-3 control-label">Confirm Password</label>
                        <div class = "col-sm-8">
                            <input type = "password" name = "verify_password" class = "form-control" placeholder = "Confirm Password" required = "" autocomplete = "off" value = "">
                        </div>
                    </div>

                    <div class = "form-group">
                        <div class = "col-sm-3 col-sm-offset-3">
                            <input type = "submit" class = "btn btn-primary" value = "Register"></button>
                        </div>
                    </div>
                </form>
            </div>
            <!-- END REGISTER TAB PANEL -->
        </div>
        <!-- END TAB CONTENT -->
    </div>
</div><?php }} ?>
