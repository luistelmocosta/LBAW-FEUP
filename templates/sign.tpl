{include file='../common/header.tpl'}

<div id="site-body" class="container">


    <!-- Modal -->
    <div class="modal fade in" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="false" style="display: block;">
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
                            <form id="loginform" role="form" action="./login?to=" method="post">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="icon-user"></i></span>
                                    <input type="text" class="form-control" id="qa-userid" name="emailhandle" placeholder="Email or Username">
                                </div>
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="icon-key"></i></span>
                                    <input type="password" class="form-control" id="qa-password" name="password" placeholder="Password">
                                </div>

                                <label class="inline">
                                    <input type="checkbox" name="remember" id="qa-rememberme" value="1"> Remember									</label>
                                <input type="hidden" name="code" value="0-1488378160-d5818bc4a4b4343aa3884610ea210f32bc31a999">
                                <input type="submit" value="Login" id="qa-login" name="dologin" class="btn btn-primary btn-large btn-block">
                            </form>
                        </div>
                        <div class="col-sm-6">
                            <form id="loginform" role="form" action="./register?to=" method="post">
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="icon-user"></i></span>
                                    <input type="text" class="form-control" id="qa-userid" name="handle" placeholder="Username">
                                </div>
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="icon-key"></i></span>
                                    <input type="password" class="form-control" id="qa-password" name="password" placeholder="Password">
                                </div>
                                <div class="input-group">
                                    <span class="input-group-addon"><i class="icon-envelope"></i></span>
                                    <input type="text" id="email" class="form-control" name="email" placeholder="Email">
                                </div>

                                <input type="hidden" name="code" value="0-1488378160-e9852b18ab3772505029c4d272cecc67cd9531af">
                                <input type="submit" value="Register" id="qa-register" name="doregister" class="btn btn-primary btn-block">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

{include file='../common/footer.tpl'}
