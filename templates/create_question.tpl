{include file='../common/header.tpl'}

<div class="main">
    <div class = "container tim-container">

        <div class = "panel panel-default">
            <div class = "panel-heading">
                <h3 class = "panel-title">Ask Question</h3>
            </div>
            <div class = "panel-body">
                <form class = "form-horizontal" method="post" action = "">


                    <div class = "form-group">
                        <label for = "title" class = "col-sm-3 control-label">Title</label>
                        <div class = "col-sm-8">
                            <input type = "text" name = "title" class = "form-control" placeholder = "Title" required
                                   value = "">
                        </div>
                    </div>

                    <div class = "form-group">
                        <label for = "username" class = "col-sm-3 control-label">Description</label>
                        <div class = "col-sm-8">
                            <textarea class = "form-control" rows = "5" placeholder = "Description" name = "body"></textarea>
                        </div>
                    </div>


                    <div class = "form-group">
                        <label for = "title" class = "col-sm-3 control-label">Tags</label>
                        <div class = "col-sm-8">
                            <select multiple name = "tags[]" class = "form-control tagable">

                            </select>
                        </div>
                    </div>

                    <div class = "form-group">
                        <div class = "col-sm-3 col-sm-offset-3">
                            <button class = "btn btn-primary" type = "submit">Create</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

{include file='../common/footer.tpl'}

</body>

<script src="../css/js/jquery-1.10.2.js" type="text/javascript"></script>
<script src="../css/js/bootstrap.js" type="text/javascript"></script>

<script src="../css/js/ct-navbar.js"></script>


</html>