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
                        <form id="loginform" role="form" action="" method="post">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                <input type="text" class="form-control" id="qa-userid" name="emailhandle" placeholder="Email or Username">
                            </div>
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-key"></i></span>
                                <input type="password" class="form-control" id="qa-password" name="password" placeholder="Password">
                            </div>

                            <label class="inline">
                                <input type="checkbox" name="remember" id="qa-rememberme" value="1"> Remember									</label>
                            <input type="hidden" name="code" value="0-1488911071-aac1367d2406bc41596c558ccf3bbd0078db4182">
                            <input type="submit" value="Login" id="qa-login" name="dologin" class="btn btn-primary btn-large btn-block">
                        </form>
                    </div>
                    <div class="col-sm-6">
                        <form id="loginform" role="form" action="./register?to=" method="post">
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-user"></i></span>
                                <input type="text" class="form-control" id="qa-userid" name="handle" placeholder="Username">
                            </div>
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-key"></i></span>
                                <input type="password" class="form-control" id="qa-password" name="password" placeholder="Password">
                            </div>
                            <div class="input-group">
                                <span class="input-group-addon"><i class="fa fa-envelope"></i></span>
                                <input type="text" id="email" class="form-control" name="email" placeholder="Email">
                            </div>

                            <input type="hidden" name="code" value="0-1488911071-3c0a8a9197e86212a6ed18e645a08cecc9fbdc58">
                            <input type="submit" value="Register" id="qa-register" name="doregister" class="btn btn-primary btn-block">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
