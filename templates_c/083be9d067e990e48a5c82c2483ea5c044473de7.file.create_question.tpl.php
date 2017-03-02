<?php /* Smarty version Smarty-3.1.15, created on 2017-03-02 08:58:06
         compiled from "..\templates\create_question.tpl" */ ?>
<?php /*%%SmartyHeaderCode:82548424058b7d71714b632-18583078%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '083be9d067e990e48a5c82c2483ea5c044473de7' => 
    array (
      0 => '..\\templates\\create_question.tpl',
      1 => 1488445081,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '82548424058b7d71714b632-18583078',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_58b7d7171f4481_85707385',
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_58b7d7171f4481_85707385')) {function content_58b7d7171f4481_85707385($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('../common/header.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>


<div id="ajax-item">
    <div id="site-body" class="container">
        <div class="clearfix qa-main">
            <div class="col-sm-12 list-c">
                <h1 class="page-title">
                    Ask a question
                </h1>
                <div class="qa-part-form">
                    <form name="ask" method="post" action="./ask">
                        <table class="qa-form-tall-table">
                            <tbody><tr>
                                <td class="qa-form-tall-label">
                                    The question in one sentence:
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-data">
                                    <input name="title" id="title" autocomplete="off" onchange="qa_title_change(this.value);" type="text" value="" class="qa-form-tall-text">
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-data">
                                    <span id="similar"></span>
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-label">
                                    Category:
                                    &nbsp;
                                    <select name="category_0" id="category_0" onchange="qa_category_select('category');" class="qa-form-tall-select" style="display: none;">
                                        <option value=""></option>
                                    </select><span id="category_0_sub"> <select name="category_1" id="category_1" onchange="qa_category_select('category');" class="qa-form-tall-select"><option value="" selected=""></option><option value="1">CleanStrap</option><option value="2">Widgets</option><option value="3">Q2A platform</option></select></span>
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-data">
                                    <div class="qa-form-tall-note"><div id="category_note"></div></div>
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-label">
                                    More information for the question:
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-data">
                                    <textarea name="editor1"></textarea>
                                    <script>
                                        CKEDITOR.replace( 'editor1' );
                                    </script>

                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-label">
                                    Tags - use comma (,) as a separator:
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-data">
                                    <input name="tags" id="tags" autocomplete="off" onkeyup="qa_tag_hints();" onmouseup="qa_tag_hints();" type="text" value="" class="qa-form-tall-text">
                                    <div class="qa-form-tall-note"><span id="tag_examples_title" style="display:none;">Example tags: </span><span id="tag_complete_title" style="display:none;">Matching tags: </span><span id="tag_hints"></span></div>
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-label">
                                    Your name to display (optional):
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-data">
                                    <input name="name" type="text" value="" class="qa-form-tall-text">
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-label">
                                    <label>
                                        <input name="notify" id="notify" onclick="if (document.getElementById('notify').checked) document.getElementById('email').focus();" type="checkbox" value="1" checked="" class="qa-form-tall-checkbox">
                                        <span id="email_shown">Email me at this address if my question is answered or commented on:</span><span id="email_hidden" style="display:none;">Email me if my question is answered or commented on</span>
                                    </label>
                                </td>
                            </tr>
                            </tbody><tbody id="email_display">
                            <tr>
                                <td class="qa-form-tall-data">
                                    <input name="email" id="email" type="text" value="" class="qa-form-tall-text">
                                    <div class="qa-form-tall-note">Privacy: Your email address will only be used for sending these notifications.</div>
                                </td>
                            </tr>
                            </tbody>
                            <tbody><tr>
                                <td colspan="1" class="qa-form-tall-buttons">
                                    <input onclick="qa_show_waiting_after(this, false); qa_ckeditor4_content.updateElement();" value="Ask the Question" title="" type="submit" class="qa-form-tall-button qa-form-tall-button-ask">
                                </td>
                            </tr>
                            </tbody></table>
                        <input type="hidden" name="editor" value="CKEditor4">
                        <input type="hidden" name="code" value="0-1488408582-78c8845912750e5b03d04095dfd67aca994b7898">
                        <input type="hidden" name="doask" value="1">
                    </form>
                </div>
            </div>
        </div>

        <?php echo $_smarty_tpl->getSubTemplate ('../common/footer.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>


    </div>
</div><?php }} ?>