<title>Search results for "{$pstext}"</title>
<div id="site-body" class="container">
    <div class="clearfix qa-main">
        <div class="home-left-inner">
            <div class="col-md-8">
                <h1 class="page-title">
                    Category questions for "<b>{$category}</b>"
                </h1>
                <br>
                <br>
                <br>

                {foreach $category_questions as $question}

                    <div class="question-summary narrow">

                        <div class="question-info col-md-12">

                            <div class="votes">
                                <div class="votes-count">
                <span title="{$question['votes_count']} votes">
                    {if $question['votes_count']}
                        {$question['votes_count']}
                    {else}
                        0
                    {/if}
                    </span>
                                </div>
                                <div>votes</div>
                            </div>

                            <div {if $question['solved_date']}
                                class="status answered-accepted"
                            {else}
                                class="status answer-selected"
                            {/if}
                                    title="one of the answers was accepted as the correct answer">
                                <div class="answers-count">
                                    <span title="{$question['answers_count']} answer">{$question['answers_count']}</span></div>
                                <div>answer</div>
                            </div>
                            <div class="views">
                                <div class="views-count">
                                    <span title="{$question['views_counter']} views">{$question['views_counter']}</span></div>
                                <div>views</div>
                            </div>

                            <div class="summary question-title">
                                <h3>
                                    <a href="{questionUrl($question['publicationid'])}"
                                       data-base-question-url = "{questionUrl('')}"
                                       style="font-size: 15px; line-height: 1.4; margin-bottom: .5em;">
                                        {$question['title']}
                                    </a>
                                </h3>
                            </div>


                            <div class = "statistics" style="padding-top: 10px">
        <span>

        <i class = "glyphicon glyphicon-time"></i>
            <span class="question-updated-at">{$question['creation_date']}</span>
            <p style="display: inline;">by </p>
            <a style="display: inline" href="{profileUrl($question['userid'])}">{$question['username']}</a>
        </span>
                            </div>
                        </div>
                    </div>

                {/foreach}
            </div>
        </div>

        <div class="col-md-4 pull-right">
            <div id="home-right-position">
                <div class="widget cs_top_contributors">
                    <h3 class="widget-title">Top Categories</h3>
                    <div class="ra-tags-widget">

                        <ul class="top-users-list clearfix">
                            {foreach $top_categories as $key => $top_category}
                                {include file="categories/top_categories.tpl"}
                            {/foreach}
                        </ul>
                    </div>
                    <br>
                    <br>
                </div>
            </div>
        </div>
    </div>
</div>