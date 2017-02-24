{include file='../common/header.tpl'}


<div class="main">
    <div class="container tim-container" style="max-width:800px; padding-top:100px">
        <h1 class="text-center">Entrar<br><small class="subtitle"> <br>Insira as suas credenciais</small>
        </h1>
        <div id = "login" role = "tabpanel" class = "tab-pane container-white active">
            <form class = "form-horizontal" action = "" method = "post">
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