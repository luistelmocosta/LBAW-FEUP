<div class="qa-a-item-main">
    <div class="asker-detail clearfix">

        <div class="user-info no-overflow">
            <h3 class="asker-name"></h3>
            <p class="asker-point"> <span class="title"></span></p>
        </div>
        <div class="enabled voting clearfix voting-vertical qa-voting-net" id="voting_187">
            <a title="" class=" fa fa-thumbs-up enabled vote-up enabled" data-original-title="Click to vote up"></a>
            <span class="count">0</span>
            <a title="" class=" fa fa-thumbs-down enabled vote-down enabled" data-original-title="Click to vote down"></a>
        </div>
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
{HTML::script('askme/comment.js')}
