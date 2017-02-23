<?php /* Smarty version Smarty-3.1.15, created on 2017-02-23 09:31:41
         compiled from "../templates/signup.tpl" */ ?>
<?php /*%%SmartyHeaderCode:169099320358ae9dedac1d80-88654776%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'eab7408ae0418ba6e9cd3f2a99183ea1197764a2' => 
    array (
      0 => '../templates/signup.tpl',
      1 => 1487838692,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '169099320358ae9dedac1d80-88654776',
  'function' => 
  array (
  ),
  'has_nocache_code' => false,
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_58ae9dedad7ba5_98920510',
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_58ae9dedad7ba5_98920510')) {function content_58ae9dedad7ba5_98920510($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('../common/header.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>


<div class="container">

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


</div><?php }} ?>
