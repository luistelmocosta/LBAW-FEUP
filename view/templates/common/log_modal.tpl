<div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
            </div>
            <div class="modal-body">
                <h3>Login or Register</h3>
                <p class="login-desc">Get access to your account and question</p>
                <div class="social-logins">
                </div>
                <div class="row">
                    <div class="col-sm-6">
                        <form class = "form-horizontal" action = "{$BASE_URL}/controller/pages/users/signin.php" method = "post">
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
                    <div class="col-sm-6">
                        <form class = "form-horizontal" action = "{$BASE_URL}../controllers/users/login.php" method = "post" enctype = "multipart/form-data">

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
                </div>
            </div>
        </div>
    </div>
</div>
