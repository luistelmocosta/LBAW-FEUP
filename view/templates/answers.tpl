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



        {include file="question_partials/vote_panel.tpl"}
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
                    <a href="../184/how-to-install-this-theme?show=187#a187" class="qa-a-item-what">answered</a>
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
                <button class="btn icon-chat showarea" title="Add a comment on this answer"
                        type="button" id="showarea" name="showarea" value="Show Textarea" data-answer={$answer['publicationid']}>
                    Comment</button>
                <div id="textarea">
                    {include file="comment_form.tpl"}
                </div>
            </div>



        </div>
    </div>

</div>
<script>
    answerid = {$answer['answerid']};
    console.log(answerid);

</script>
{HTML::script('comment.js')}
