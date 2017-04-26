<div class="question-summary narrow">

    <div class="col-md-12">

        <div class="votes">
            <div class="mini-counts"><span title="7 votes">
                    {if $question['votes_count']}
                        {$question['votes_count']}
                    {else}
                        0
                    {/if}
                    </span></div>
            <div>votes</div>
        </div>
        <div {if $question['solved_date']}
            class="status answered-accepted"
        {else}
            class="status answer-selected"
        {/if}
                title="one of the answers was accepted as the correct answer">
            <div class="mini-counts"><span title="1 answer">{$question['answers_count']}</span></div>
            <div>answer</div>
        </div>
        <div class="views">
            <div class="mini-counts"><span title="140 views">{$question['views_counter']}</span></div>
            <div>views</div>
        </div>

        <div class="summary">
            <h3>
                <a href="{questionUrl($question['publicationid'])}" class="question-hyperlink" style="font-size: 15px; line-height: 1.4; margin-bottom: .5em;">
                    {$question['title']}
                </a>
            </h3>
        </div>


        <div class = "statistics col-sm-12 text-right" style="padding-top: 8px; padding-right: 70px">
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


















