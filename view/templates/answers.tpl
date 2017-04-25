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
                <button class="btn icon-chat" title="Add a comment on this answer"
                        type="button" id="showarea" name="showarea" value="Show Textarea">
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
    $("#showarea").click(function() {

        $.getJSON("/controller/api/comments/comment.php", {
            answerid : answerid
        }, function (data) {
            $.each(data, function(i, comment) {

                $('#textarea').before('<article class="tweet-data">' +
                    '<div class="comment-items">' +
                    '<div class="qa-c-list-item  hentry comment" id="c3574">' +
                    '<div class="asker-avatar">' +
                    '<a href="../user/lbaw1641">' +
                    '<img src="http://www.gravatar.com/avatar/8b21c0ba9bf921fa9aecfbfa62e26e08?s=30"></a>' +
                    '</div>' +
                    '<div class="qa-c-wrap">' +
                    '<div class="post-button">' +
                    '<button name="c3574_doflag" onclick="return qa_comment_click(3574, 3557, 3565, this);" class="btn icon-flag" title="Flag this comment as spam or inappropriate" type="submit">flag</button>' +
                    '<button name="a3565_docomment" class="btn icon-answers" title="Reply to this comment" type="submit">reply</button>' +
                    '</div>' +
                    '<span class="qa-c-item-meta">' +
                    '<a href="../3557/how-to-upload-featured-image-while-adding-new-post?show=3574#c3574" class="qa-c-item-what">commented</a>'+
                    '<span class="qa-c-item-when">' +
                    '<span class="qa-c-item-when-data"><span class="published">' +
                    '<span class="value-title" title="2017-04-21T00:27:53+0000">' +
                    '</span> 1 day</span></span><span class="qa-c-item-when-pad"> ago</span> ' +
                    '</span> ' +
                    '<span class="qa-c-item-who"> ' +
                    '<span class="qa-c-item-who-pad">by </span> ' +
                    '<span class="qa-c-item-who-data"><span class="vcard author"><a href="../user/lbaw1641" class="qa-user-link url nickname">' +
                    comment.username +
                    '</a></span></span> ' +
                    '<span class="qa-c-item-who-points"> ' +
                    '<span class="qa-c-item-who-points-pad">(</span><span class="qa-c-item-who-points-data">140</span><span class="qa-c-item-who-points-pad"> points)</span> ' +
                    '</span> ' +
                    '</span> ' +
                    '</span> ' +
                    '<div class="qa-c-item-content"> ' +
                    '<a name="3574"></a><div class="entry-content">' +
                    comment.body +
                    '</div> ' +
                    '</div> ' +
                    '</div> <!-- END qa-c-item --> ' +
                    '</div> ' +
                    '</div>');
                $('#showarea').fadeOut();
            });
        });
    });
</script>
{HTML::script('askme/comment.js')}
