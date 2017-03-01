<?php /* Smarty version Smarty-3.1.15, created on 2017-02-24 13:35:14
         compiled from "../templates/signin.tpl" */ ?>
<?php /*%%SmartyHeaderCode:165340039858ae9cabdbaa15-80728773%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '0270357f065f83bac2a2d0bac18bf9d84e2568bf' => 
    array (
      0 => '../templates/signin.tpl',
      1 => 1487939711,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '165340039858ae9cabdbaa15-80728773',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_58ae9cac2790b3_23827969',
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_58ae9cac2790b3_23827969')) {function content_58ae9cac2790b3_23827969($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('../common/header.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>



<div class="main">
    <div class="container tim-container" style="max-width:500px; ">
        <h1 class="text-center">Entrar<br><small class="subtitle"> <br>Insira as suas credenciais</small>
        </h1>
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

    </div>
</div>

<br>
<br>
<?php echo $_smarty_tpl->getSubTemplate ('../common/footer.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>


</body>

<script src="../css/js/jquery-1.10.2.js" type="text/javascript"></script>
<script src="../css/js/bootstrap.js" type="text/javascript"></script>

<script src="../css/js/ct-navbar.js"></script>


</html><?php }} ?>
