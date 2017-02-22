<?php /* Smarty version Smarty-3.1.15, created on 2017-02-22 01:09:48
         compiled from "/home/luiscosta/PhpstormProjects/LBAW-FEUP/common/header.tpl" */ ?>
<?php /*%%SmartyHeaderCode:18993846358acd24d519cf7-21928353%%*/if(!defined('SMARTY_DIR')) exit('no direct access allowed');
$_valid = $_smarty_tpl->decodeProperties(array (
  'file_dependency' => 
  array (
    'e1dcbffe67d1b08bdd1ad640c7e3886e1024d389' => 
    array (
      0 => '/home/luiscosta/PhpstormProjects/LBAW-FEUP/common/header.tpl',
      1 => 1487722173,
      2 => 'file',
    ),
  ),
  'nocache_hash' => '18993846358acd24d519cf7-21928353',
  'function' => 
  array (
  ),
  'version' => 'Smarty-3.1.15',
  'unifunc' => 'content_58acd24d5a8ff0_57499743',
  'variables' => 
  array (
    'BASE_URL' => 0,
  ),
  'has_nocache_code' => false,
),false); /*/%%SmartyHeaderCode%%*/?>
<?php if ($_valid && !is_callable('content_58acd24d5a8ff0_57499743')) {function content_58acd24d5a8ff0_57499743($_smarty_tpl) {?><!DOCTYPE html>
<html>
<head>
    <title>LBAW - AskMe</title>

    <meta charset = "UTF-8">

    <link rel = "stylesheet" type = "text/css" href = "//fonts.googleapis.com/css?family=Open+Sans"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
          integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
            integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
            crossorigin="anonymous"></script>



</head>
<body>
<nav class = "navbar navbar-default">
    <div class = "container">
        <div class = "container-fluid">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class = "navbar-header">
                <button type = "button" class = "navbar-toggle collapsed" data-toggle = "collapse" data-target = "#bs-example-navbar-collapse-1" aria-expanded = "false">
                    <span class = "sr-only">Toggle navigation</span>
                    <span class = "icon-bar"></span>
                    <span class = "icon-bar"></span>
                    <span class = "icon-bar"></span>
                </button>
                <a class = "navbar-brand" href = "/" style = "padding: 2px 0">

                </a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class = "collapse navbar-collapse" id = "bs-example-navbar-collapse-1">
                <ul class = "nav navbar-nav navbar-right">



                    <form class = "navbar-form navbar-left" role = "search" method = "post" action = "<?php echo $_smarty_tpl->tpl_vars['BASE_URL']->value;?>
pages/questions/search.php">
                        <div class = "form-group">
                            <input type = "text" class = "form-control navbar-search" placeholder = "Search" name = "search_query">
                        </div>

                        <a>
                            <button type = "submit" class = "search-submit">
                                <span class = "glyphicon glyphicon-search"></span>
                            </button>
                        </a>
                    </form>
                </ul>
            </div><!-- /.navbar-collapse -->
        </div><!-- /.container-fluid -->
    </div>
</nav><?php }} ?>
