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
    
    <br class = "clearfix">

    {if $LOGGED_IN}
        {HTML::script('question.js')}
    {/if}


    </body>
    </html>
</footer>