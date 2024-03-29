{include file= 'common/narrow_header.tpl'}
<title>SignUp</title>
<body id="site-body" class="container">
{include file="common/messages.tpl"}
<div class="clearfix qa-main">
    <h1 align="center">Create a new account</h1>
    <br class="clearfix">
    <br class="clearfix">
    <div class = "container">

        <!-- REGISTER TAB PANEL -->
        <div role = "tabpanel" class = "tab-pane container-white"  id = "register">
            <form class = "form-horizontal" action = "{$BASE_URL}controller/actions/users/signup.php" name="signupform" method = "post" enctype = "multipart/form-data" onsubmit="return validateForm()">

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
        <!-- END REGISTER TAB PANEL -->
    </div>
</div>

{HTML::script('form-validation.js')}