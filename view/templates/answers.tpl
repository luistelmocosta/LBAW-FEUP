<div class="qa-a-item-main">
    <div class="asker-detail clearfix">
        <div class="asker-avatar avatar"><a href={profileUrl($answer['userid'])}>
                <img width="40"
                     height="40" class="qa-avatar-image" src="{$answer['user_photo']}">
            </a>
        </div>
        <div class="user-info no-overflow">
            <h3 class="asker-name">
                <a href={profileUrl($answer['userid'])}>{$answer['username']}</a>

            </h3>
            <p class="asker-point">
                {$answer['answer_user_points']} points
            </p>
            <span class="title" style="background: #EEEEEE;">{$answer['role']}</span>
        </div>



        {include file="answers_partials/vote_panel.tpl"}
        <blockquote class="accept-answer text-right {if !$isMine} hidden{/if}" >
            <div class="accept" title="Accept this answer" data-url="{url('controller/api/questions/mark_as_solved')}" data-refresh="{url('controller/api/questions/refresh_accepted_answers')}" data-answer="{$answer['answerid']}" data-question="{$question['publicationid']}">
                <div class="accepted up" title="Unnacept this answer"></div>
            </div>
        </blockquote>
        <!-- <button class = "btn btn-success question-solved{if $answer['solved_date'] || !$isMine} hidden{/if}"
                data-url="{url('controller/api/questions/mark_as_solved')}" data-answer="{$answer['answerid']}" data-question="{$question['publicationid']}">Accept this answer</button> -->


        <form method="post" action="">
            <div class="qa-a-selection">
            </div>
            <input name="code" type="hidden">
            <input name="qa_click" value="" type="hidden">
        </form>
    </div>

    <div class="a-item-inner-wrap">
        <div class="a-item-wrap">
            <div class="qa-a-item-content">
                <a name="187"></a><div class="entry-content">{$answer['body']}</div>
            </div>
            <span class="qa-a-item-meta">
                    answered
                    <span class="qa-a-item-when">
                        <span class="qa-a-item-when-data">
                            <span class="published">
                                <span class="value-title" title="">
                                </span>{$answer['creation_date']}</span></span>
                    </span>
                    <span class="qa-a-item-who">
                        <span class="qa-a-item-who-pad">by</span>
                        <span class="qa-q-item-who-data">
                        <span class="qa-a-item-who-data"><span class="vcard author"><a style="display: inline;" href={profileUrl($answer['userid'])} class="qa-user-link">{$answer['username']}</a></span></span>
                    </span>
                </span>
            <div class="post-button clearfix">
                <a href="{editAnswerUrl($answer['answerid'])}" class = "btn {if !$isMine}hidden{/if}">Edit</a>
                <div class="post-button clearfix">
                    <button class="btn icon-chat show-textarea"
                            title="Add a comment on this answer"
                            type="button" data-answer="{$answer['answerid']}"
                            data-question="{$question['publicationid']}"
                            data-type="answer">{$answer['total_comments']} Comments</button>
                    <div class="textarea">
                        {include file="answers_partials/comment_form.tpl"}
                    </div>
                </div>
            </div>



        </div>
    </div>

</div>
{HTML::script('accept-answer.js')}
