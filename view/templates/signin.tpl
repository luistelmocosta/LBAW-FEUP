{include file= 'common/narrow_header.tpl'}
<title>SignIn</title>
{include file="common/messages.tpl"}
<body id="site-body" class="container">
<div class="clearfix qa-main">
    <div class = "container">
        <div class = "col-sm-8 col-sm-offset-2">
            <!-- TAB CONTENT -->
            <h1>Enter your credentials</h1>
            <div class = "tab-content">
                <!-- LOGIN TAB PANEL -->
                <div id = "login" role = "tabpanel" class = "tab-pane container-white active">
                    <form class = "form-horizontal" action = "../../actions/users/signin.php" method = "POST">
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
                                <!--modal-->
                                <div id="forgotPassword" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                                <h1 class="text-center">What's My Password?</h1>
                                            </div>
                                            <div class="modal-body">
                                                <div class="col-md-12">
                                                    <div class="panel panel-default">
                                                        <div class="panel-body">
                                                            <div class="text-center">

                                                                <p>If you have forgotten your password you can reset it here.</p>
                                                                <div class="panel-body">
                                                                    <fieldset>
                                                                        <div class="form-group">
                                                                            <input class="form-control input-lg" placeholder="E-mail Address" name="email" type="email">
                                                                        </div>
                                                                        <input class="btn btn-lg btn-primary btn-block" value="Send My Password" type="submit">
                                                                    </fieldset>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal-footer">
                                                <div class="col-md-12">
                                                    <button class="btn" data-dismiss="modal" aria-hidden="true">Cancel</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class = "col-sm-5 text-right">
                                <a href = "/../../controller/pages/users/signup.php" class = "small"> New User? Click here!</a>
                            </div>
                        </div>
                    </form>
                </div>
                <!-- END LOGIN TAB PANEL -->

                <!-- END TAB CONTENT -->
            </div>
        </div>
    </div>

