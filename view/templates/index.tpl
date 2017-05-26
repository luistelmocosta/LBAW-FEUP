<!-- Set your background image for this header on the line below. -->
<title>AskMe</title>

<header class="intro-header" style="background-image: url('{$BASE_URL}images/background.png')">
    {include file="common/messages.tpl"}
    <div class="container">

        <div class="row">
            <div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
                <div class="site-heading">

                    <h1>AskMe</h1>
                    <br>

                    <form name="search" method="post" action="{$BASE_URL}controller/pages/questions/search_results.php">
                        <div id="custom-search-input">
                            <div class="input-group col-lg-12">
                                <input type="text" name="psearch" class="form-control input-lg" placeholder="Search for a question..."/>
                                <span class="input-group-btn">
                                    <button class="btn btn-info">
                                    <i class="glyphicon glyphicon-search"></i>
                                </button>
                                </span>
                            </div>
                        </div>
                    </form>

                    <br><br>

                    <ul class = "list-inline intro-social-buttons">
                        <li>
                            <a href = "{$BASE_URL}controller/pages/about.php" class = "btn btn-warning btn-md">
                                <span class = "network-name">About Us</span>
                            </a>
                        </li>
                        <li>
                            <a href = "{$BASE_URL}controller/pages/questions/create_question.php" class = "btn btn-success btn-md">
                                <span class = "network-name">Ask Now!</span>
                            </a>
                        </li>
                        <li>
                            <a href = "https://github.com/luistelmocosta/LBAW-FEUP" class = "btn btn-danger btn-md" target = "_blank"><i class = "fa fa-github fa-fw"></i>
                                <span class = "network-name">GITHUB</span></a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</header>


<div id="site-body" class="container">
    <div class="clearfix qa-main">
        <div class="home-left-inner">

            <div class="col-md-8">

                <div id="tabs" class="tab-content">
                    <ul>
                        <li><a href="#recent_questions">Recent Questions</a></li>
                        <li><a href="#unanswered_questions">Unanswered Questions</a></li>
                        <li><a href="#top">Top Scored Questions</a></li>
                    </ul>
                    {if empty($recent_questions)}
                        <div class = "col-sm-12" style = "text-align: center"><strong>No questions to load!</strong></div>
                    {/if}
                    {if !empty($recent_questions)}
                        <div id="recent_questions" class="question-col">
                            {foreach $recent_questions as $question}
                                {include file="recent_questions.tpl"}
                            {/foreach}

                            <div class = "loadMore"
                                 data-next-page = "1"
                                 data-url = "{url('controller/api/questions/load_more_questions')}"
                                 data-tab = "recent_questions">
                                <a style="color: #f9f9f9">
                                    Load More...
                                </a>
                            </div>
                        </div>
                    {/if}

                    <div id="unanswered_questions" class="question-col">
                        {foreach $unanswered_questions as $question}
                            {include file="unanswered_questions.tpl"}
                        {/foreach}

                        <div class = "loadMore"
                             data-next-page = "1"
                             data-url = "{url('controller/api/questions/load_more_questions')}"
                             data-tab = "unanswered_questions">
                            <a style="color: #f9f9f9">
                                Load More...
                            </a>
                        </div>
                    </div>
                    <div id="top" class="question-col">
                        {foreach $top_scored_questions as $question}
                            {include file="top_scored_questions.tpl"}
                        {/foreach}

                        <div class = "loadMore"
                             data-next-page = "1"
                             data-url = "{url('controller/api/questions/load_more_questions')}"
                             data-tab = "top">
                            <a style="color: #f9f9f9">
                                Load More...
                            </a>
                        </div>
                    </div>
                    <div class="clearfix"></div>
                </div>
            </div>

        </div>
        <div class="col-md-4 pull-right">
            <div id="home-right-position">
                <div class="widget cs_top_contributors">
                    <h3 class="widget-title">Top Scored Users</h3>
                    <div class="ra-tags-widget">

                        <ul class="top-users-list clearfix">
                            {foreach $top_scored_users as $user}
                                {include file="sidebar_partials/top_scored_users.tpl"}
                            {/foreach}
                        </ul>
                    </div>
                    <br>
                    <br>
                    <div class="widget status" >
                        <h3 class="widget-title">Site Status</h3>
                        <canvas id="siteStats" width="350" height="300" style="padding-left: 10px">
                        </canvas>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


{HTML::script('index.js')}


