<div class="qa-a-item-main">
    <div class="asker-detail clearfix">
        <div class="asker-avatar avatar"><a href="../user/admin">
                <img width="40"
                     height="40" class="qa-avatar-image" src="{$answer['user_photo']}">
            </a>
        </div>
        <div class="user-info no-overflow">
            <h3 class="asker-name">
                {$answer['username']}
            </h3>
            <p class="asker-point">
                {$answer['answer_user_points']} points
            </p>
            <span class="title" style="background: #EEEEEE;">{$answer['role']}</span>
        </div>



        {include file="answers_partials/vote_panel.tpl"}

        <button class = "btn btn-success question-solved{if $answer['solved_date'] || !$isMine} hidden{/if}"
                data-url="{url('controller/api/questions/mark_as_solved')}" data-answer="{$answer['answerid']}" data-question="{$question['publicationid']}">Accept this answer</button>

        <script>

            $(".question-solved").on('click', function () {
                console.log("Hello");
                var url = $(this).data('url');
                var parent = $(this).closest('.question-info-container');
                var qid = $(this).data('question');
                var aid = $(this).data('answer');
                console.log(qid);
                console.log(aid);
                var current = $(this);

                $.get(url + '?question=' + qid + '&answer=' + aid, function (data) {
                    console.log("Reading...");
                    data = $.parseJSON(data);
                    console.log(data);
                    if (data.status) {
                        parent.find('.question-solved-status').removeClass('text-danger').addClass('text-success');
                        parent.find('.question-solved-status').find('span').html('Solved');
                        current.addClass('hidden');
                    }
                });
            });
        </script>
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
                        <span class="qa-a-item-who-data">{$answer['username']}</span>
                    </span>
                </span>
            <div class="post-button clearfix">
                <div class="post-button clearfix">
                    <button class="btn icon-chat show-textarea" title="Add a comment on this answer" type="button" data-answer="{$answer['answerid']}">{$answer['total_comments']} Comments</button>
                    <div class="textarea">
                        {include file="comment_form.tpl"}
                    </div>
                </div>
            </div>



        </div>
    </div>

</div>
{HTML::script('comment.js')}
