<?php /* Smarty version Smarty-3.1.15, created on 2017-02-23 23:27:51
         compiled from "../templates/create_question.tpl" */ ?>
<?php /*%%SmartyHeaderCode:74147825258af6112b9bd90-74860748%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '1a1358ab074009698947fbcd5d8013885ed4b07b' => 
    array (
      0 => '../templates/create_question.tpl',
      1 => 1487888862,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '74147825258af6112b9bd90-74860748',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_58af6112d67862_37257117',
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_58af6112d67862_37257117')) {function content_58af6112d67862_37257117($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('../common/header.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>

<div class = "container">

    <div class = "panel panel-default">
        <div class = "panel-heading">
            <h3 class = "panel-title">Ask Question</h3>
        </div>
        <div class = "panel-body">
            <form class = "form-horizontal" method="post" action = "">


                <div class = "form-group">
                    <label for = "title" class = "col-sm-3 control-label">Title</label>
                    <div class = "col-sm-8">
                        <input type = "text" name = "title" class = "form-control" placeholder = "Title" required
                               value = "">
                    </div>
                </div>

                <div class = "form-group">
                    <label for = "username" class = "col-sm-3 control-label">Description</label>
                    <div class = "col-sm-8">
                        <textarea class = "form-control" rows = "5" placeholder = "Description" name = "body"></textarea>
                    </div>
                </div>


                <div class = "form-group">
                    <label for = "title" class = "col-sm-3 control-label">Tags</label>
                    <div class = "col-sm-8">
                        <select multiple name = "tags[]" class = "form-control tagable">

                        </select>
                    </div>
                </div>



                <div class = "form-group">
                    <div class = "col-sm-3 col-sm-offset-3">
                        <button class = "btn btn-primary" type = "submit">Create</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<?php echo $_smarty_tpl->getSubTemplate ('../common/footer.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>
<?php }} ?>
