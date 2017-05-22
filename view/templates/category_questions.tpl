<title>Search results for "{$pstext}"</title>
<div id="site-body" class="container">
    <div class="clearfix qa-main">
        <div class="col-sm-8 list-c">
            <h1 class="page-title">
                Category questions for "<b>{$category}</b>"
            </h1>
        </div>
        <br>
        <br>
        <br>

        {foreach $category_questions as $res}

            <div class="question-summary narrow">

                <div class="col-md-12">

                    <div class="votes" style="float: right">
                        <div class="mini-counts"><span title="votes">
                    {if $res['votes_count']}
                        {$res['votes_count']}
                    {else}
                        0
                    {/if}
                    </span></div>
                        <div>votes</div>
                    </div>

                    <div class="views" style="float: right">
                        <div class="mini-counts"><span title="views">{$res['views_counter']}</span></div>
                        <div>views</div>
                    </div>

                    <div class="summary">
                        <h3>
                            <a href={questionUrl($res['publicationid'])} class="question-hyperlink" style="font-size: 15px; line-height: 1.4; margin-bottom: .5em;">
                                {$res['title']}
                            </a>
                        </h3>
                    </div>

                    <div class = "statistics col-md-12 text-right" style="padding-top: 8px; padding-right: 50px">
                        <span>
                            <i class = "glyphicon glyphicon-time"></i>
                            <span class="question-updated-at">10 min ago</span>
                        </span>
                        <span>
                            <i class = "glyphicon glyphicon-comment"></i>
                            <span class="question-answers">1</span>
                        </span>
                    </div>
                </div>

            </div>

        {/foreach}

    </div>
</div>