{include file= 'common/narrow_header.tpl'}

<body id="site-body" class="container">
<div class="clearfix qa-main">
    <div class = "container">
        <div class = "col-sm-8 col-sm-offset-2">
            <!-- TABS START -->
            <ul class = "nav nav-tabs">
                <li class = "active">
                    <a href = "#login" aria-controls = "login" role = "tab" data-toggle = "tab">Log In</a>
                </li>
                <li class = "active">
                    <a href = "#register" aria-controls = "register" role = "tab" data-toggle = "tab">Sign Up</a>
                </li>
            </ul>
            <!-- END TABS -->
            <!-- TAB CONTENT -->
            <div class = "tab-content">
                <!-- LOGIN TAB PANEL -->
                <div id = "login" role = "tabpanel" class = "tab-pane container-white active">
                    <form class = "form-horizontal" action = "" method = "POST">
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
                <!-- END LOGIN TAB PANEL -->

            <!-- END TAB CONTENT -->
        </div>
    </div>
</div>

