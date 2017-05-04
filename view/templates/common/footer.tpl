<footer>
    <div class="row">
        <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
            <ul class="list-inline text-center">
                <li>
                    <a href="{$BASE_URL}controller/pages/about.php">
                                <span class="fa-stack fa-lg">
                                    <i class="fa fa-circle fa-stack-2x"></i>
                                    <i class="fa fa-info fa-stack-1x fa-inverse" style="background: #96221f;"></i>
                                </span>
                    </a>
                </li>
                <li>
                    <a href="https://github.com/luistelmocosta/LBAW-FEUP">
                                <span class="fa-stack fa-lg">
                                    <i class="fa fa-circle fa-stack-2x"></i>
                                    <i class="fa fa-github fa-stack-1x fa-inverse"></i>
                                </span>
                    </a>
                </li>
            </ul>
            <p class="copyright text-muted">Copyright &copy; LBAW FEUP 2016/2017</p>
        </div>
    </div>

    {foreach $SUCCESS_MESSAGES as $message}
        <div class = "alert alert-success alert-dismissible" role = "alert">
            <button type = "button" class = "close" data-dismiss = "alert" aria-label = "Close">
                <span aria-hidden = "true">&times;</span></button>
            <strong>Success!</strong> {$message}
        </div>
    {/foreach}
    {foreach $ERROR_MESSAGES as $message}
        <div class = "alert alert-danger alert-dismissible" role = "alert">
            <button type = "button" class = "close" data-dismiss = "alert" aria-label = "Close">
                <span aria-hidden = "true">&times;</span></button>
            <strong>Danger!</strong> {$message}
        </div>
    {/foreach}
    <br class = "clearfix">


    {HTML::script('question.js')}

    </body>
    </html>
</footer>