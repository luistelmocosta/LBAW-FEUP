<?php /* Smarty version Smarty-3.1.15, created on 2017-02-24 00:56:30
         compiled from "../templates/question.tpl" */ ?>
<?php /*%%SmartyHeaderCode:29357970158af62dd800295-97657523%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    '970155cd69e543ff2e10d8cade9b895073d1bb58' => 
    array (
      0 => '../templates/question.tpl',
      1 => 1487894172,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '29357970158af62dd800295-97657523',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_58af62dd802b41_12763247',
  'variables' => 
  array (
    'question' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_58af62dd802b41_12763247')) {function content_58af62dd802b41_12763247($_smarty_tpl) {?><?php echo $_smarty_tpl->getSubTemplate ('../common/header.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>


<div class="container" style="margin-top: 2em">

    <h1>Question Details</h1>
    <div class="question_space">
        <div class = "col-sm-12 container-white question-info-container" data-id="">

            <div class = "col-sm-2">
                <span class="pull-right">
                        <i id="like1" class="glyphicon glyphicon-thumbs-up"></i> <div id="like1-bs3"></div>
                        <i id="dislike1" class="glyphicon glyphicon-thumbs-down"></i> <div id="dislike1-bs3"></div>
                    </span>


            </div>
            <div class = "col-sm-10">
                <h3>
                    <a href = "" class = "question-title" data-base-question-url = "">

                    </a>
                </h3>
                <p class = "question-description">
                    <a href = "" class = "question-body" data-base-question-url = "">

                    </a>
                </p>
                <div class = "options pull-right" style = "margin-bottom:5px;">
                    <button class = "btn btn-primary btn-xs edit-question" data-url = "">Edit</button>
                    <button class = "btn btn-success btn-xs trigger-question-solved"
                            data-url="">Mark as solved</button>
                </div>
            </div>

            <div class = "statistics col-sm-12 text-center">
        <span>
            <i class = "glyphicon glyphicon-user"></i>
             <a href = "" class = "question-user" data-url = "">

            </a>
        </span>

                    <span class = "text-success question-solved-status">
                <i class = "glyphicon glyphicon-check"></i>
                <span>Solved</span>
            </span>

                    <span class = "text-danger question-solved-status">
                <i class = "glyphicon glyphicon-check"></i>
                <span>Not Solved</span>
            </span>

                <span>
            <i class = "glyphicon glyphicon-time"></i>
            <span class = "question-updated-at">

            </span>
        </span>
                <span>
            <i class = "glyphicon glyphicon-comment"></i>
            <span class = "question-answers"><?php echo $_smarty_tpl->tpl_vars['question']->value['number_answers'];?>
 answer<?php if ($_smarty_tpl->tpl_vars['question']->value['number_answers']!=1) {?>s<?php }?></span>
        </span>
            </div>
        </div>
    </div>

    <div class="answer_space ">


    </div>


</div>


<?php echo $_smarty_tpl->getSubTemplate ('../common/footer.tpl', $_smarty_tpl->cache_id, $_smarty_tpl->compile_id, 0, null, array(), 0);?>
<?php }} ?>
