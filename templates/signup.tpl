{include file='../common/header.tpl'}

<div class="main">
    <div class="container tim-container" style="max-width:800px; padding-top:50px">

        <h1 class="text-center">Registar<br><small class="subtitle"> <br>Criar nova conta</small>
        </h1>

        <div role = "tabpanel" class = "tab-pane container-white active" id = "register">
            <form class = "form-horizontal" action = "" method = "post" enctype = "multipart/form-data">

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

<br>
<br>
{include file='../common/footer.tpl'}

</body>

<script src="../css/js/jquery-1.10.2.js" type="text/javascript"></script>
<script src="../css/js/bootstrap.js" type="text/javascript"></script>

<script src="../css/js/ct-navbar.js"></script>


</html>