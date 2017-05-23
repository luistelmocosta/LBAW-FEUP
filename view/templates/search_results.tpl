<title>Search results for "{$pstext}"</title>
<div id="site-body" class="container">
    <div class="clearfix qa-main">
        {if sizeof($search_questions) > 0}
            <div class="col-md-12 list-c">
                <h1 class="page-title">
                    Question results for "<b>{$pstext}</b>"
                </h1>
            </div>
        {/if}
        <br>
        <br>
        <br>
        <div class="home-left-inner">
            <div class="col-md-8">
                <div class="question-col">
                    {foreach $search_questions as $res}

                        <div class="question-summary narrow">

                            <div class="question-info col-md-12">

                                <div class="votes" style="float: right">
                                    <div class="votes-count"><span title="votes">
                    {if $res['votes_count']}
                        {$res['votes_count']}
                    {else}
                        0
                    {/if}
                    </span></div>
                                    <div>votes</div>
                                </div>

                                <div {if $res['solved_date']}
                                    class="status answered-accepted"
                                {else}
                                    class="status answer-selected"
                                {/if}
                                        title="one of the answers was accepted as the correct answer" style="float: right">
                                    <div class="answers-count">
                                        <span title="{$res['answers_count']} answer">{$res['answers_count']}</span></div>
                                    <div>answer</div>
                                </div>

                                <div class="views" style="float: right">
                                    <div class="views-count"><span title="views">{$res['views_counter']}</span></div>
                                    <div>views</div>
                                </div>

                                <div class="summary question-title">
                                    <h3>
                                        <a href="{questionUrl($res['publicationid'])}"
                                           data-base-question-url = "{questionUrl('')}"
                                           style="font-size: 15px; line-height: 1.4; margin-bottom: .5em;">
                                            {$res['title']}
                                        </a>
                                    </h3>
                                </div>

                                <div class = "statistics col-sm-12 text-right" style="padding-top: 8px">
            <span>
                <i class = "glyphicon glyphicon-time"></i>
                <span class="question-updated-at">{$res['creation_date']}</span>
            </span>
                                    <span>
                <i class = "glyphicon glyphicon-comment"></i>
                <span class="question-answers">{$res['answers_count']}</span>
            </span>
                                </div>
                            </div>

                        </div>

                    {/foreach}

                    <br class="clearfix">
                    <br class="clearfix">
                    <br class="clearfix">

                    {if sizeof($search_answers) > 0}
                        <div class="col-sm list-c">
                            <h4 class="page-title" style="color: #5e5e5e">
                                Answers results for "<b>{$pstext}</b>"
                            </h4>
                        </div>
                    {/if}



                    {foreach $search_answers as $res}

                        <div class="question-summary narrow">

                            <div class="col-md-12">

                                <div class="votes" style="float: right">
                                    <div class="votes-count"><span title="votes">
                                            {if $res['votes_count']}
                                                {$res['votes_count']}
                                            {else}
                                                0
                                            {/if}
                    </span></div>
                                    <div>votes</div>
                                </div>

                                <div class="summary question-title">
                                    <h3>
                                        <a href="{questionUrl($res['publicationid'])}"
                                           data-base-question-url = "{questionUrl('')}"
                                           style="font-size: 15px; line-height: 1.4; margin-bottom: .5em;">
                                            {$res['body']}

                                        </a>
                                        <span class="qa-c-item-meta">
                                            {$res['title']}
                                        </span>
                                    </h3>
                                </div>

                                <div class = "statistics col-sm-12 text-right" style="padding-top: 8px">
            <span>
                <i class = "glyphicon glyphicon-time"></i>
                <span class="question-updated-at">{$res['creation_date']}</span>
            </span>
                                </div>
                            </div>

                        </div>

                    {/foreach}

                    <br class="clearfix">
                    <br class="clearfix">
                    <br class="clearfix">


                    {if sizeof($search_tags[0]) > 0}
                        <h1 class="page-title">
                            Tags results for "<b>{$pstext}</b>"
                        </h1>
                    {/if}




                    {foreach $search_tags as $res}

                        <div class="question-summary narrow">

                            <div class="col-md-12">

                                <div class="votes" style="float: right">
                                    <div class="votes-count"><span title="votes">
                    {if $res['votes_count']}
                        {$res['votes_count']}
                    {else}
                        0
                    {/if}
                    </span></div>
                                    <div>votes</div>
                                </div>

                                <div {if $res['solved_date']}
                                    class="status answered-accepted"
                                {else}
                                    class="status answer-selected"
                                {/if}
                                        title="one of the answers was accepted as the correct answer" style="float: right">
                                    <div class="answers-count">
                                        <span title="{$res['answers_count']} answer">{$res['answers_count']}</span></div>
                                    <div>answer</div>
                                </div>

                                <div class="views" style="float: right">
                                    <div class="views-count"><span title="views">{$res['views_counter']}</span></div>
                                    <div>views</div>
                                </div>

                                <div class="summary question-title">
                                    <h3>
                                        <a href="{questionUrl($res['publicationid'])}"
                                           data-base-question-url = "{questionUrl('')}"
                                           style="font-size: 15px; line-height: 1.4; margin-bottom: .5em;">
                                            {$res['title']}
                                        </a>
                                        <div class="question-tags">
                                            <ul class="tags-tag-list">
                                                {foreach $res['tags'] as $key => $tag}
                                                    <li><a href="" class="widget-tag">{$tag['name']}</a></li>
                                                {/foreach}
                                            </ul>
                                        </div>
                                    </h3>
                                </div>

                                <div class = "statistics col-sm-12 text-right" style="padding-top: 8px">
            <span>
                <i class = "glyphicon glyphicon-time"></i>
                <span class="question-updated-at">{$res['creation_date']}</span>
            </span>
                                    <span>
                <i class = "glyphicon glyphicon-comment"></i>
                <span class="question-answers">{$res['answers_count']}</span>
            </span>
                                </div>
                            </div>

                        </div>

                    {/foreach}
                </div>
            </div>
        </div>
    </div>
</div>