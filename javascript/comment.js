$('.comment-form').hide();
var commentsFetched = false;

$("body").on("click", ".show-textarea", function(){

    var answerid = $(this).data('answer');
    var $commentForm = $(this).parent().find('.comment-form').first();
    console.log(answerid);
    $.getJSON("/controller/api/comments/comment.php", {
        answerid : answerid
    }, function (data) {
        $commentForm.find('article').remove();
        console.log("AID " + answerid);
        console.log("Data" + data);
        $.each(data, function(i, comment) {
            console.log("Comment:" + comment);
            $commentForm.append('<article class="tweet-data">' +
                '<div class="comment-items">' +
                '<div class="qa-c-list-item  hentry comment" id="c3574">' +
                '<div class="asker-avatar">' +
                '<a>' +
                '<img width="40" height="40" src="' +
                comment.user_photo +
                '"></a>' +
                '</div>' +
                '<div class="qa-c-wrap">' +
                '<div class="post-button">' +
                '<button name="" onclick="" class="btn icon-flag" title="Flag this comment as spam or inappropriate" type="submit">flag</button>' +
                '<button name="" class="btn icon-answers" title="Reply to this comment" type="submit">reply</button>' +
                '</div>' +
                '<span class="qa-c-item-meta">' +
                'commented' +
                ' 1 day' +
                ' ago' +
                ' by ' +
                '<a style="display: inline" href="" class="qa-user-link url nickname">' +
                comment.username +
                '</a> ' +
                '<span class="qa-c-item-who-points"> ' +
                '<span class="qa-c-item-who-points-pad">(</span><span class="qa-c-item-who-points-data">140</span><span class="qa-c-item-who-points-pad"> points)</span> ' +
                '</span> ' +
                '</span> ' +
                '</span> ' +
                '<div class="qa-c-item-content" style="color: #2d2727; font-size: 13px"> ' +
                '<a name="3574"></a><div class="entry-content">' +
                comment.body +
                '</div> ' +
                '</div> ' +
                '<a href="{editQuestionUrl(' +
                comment.publicationid +
            ' )}" class = "btn {if !$isMine}hidden{/if}">Edit</a>' +
                '</div> <!-- END qa-c-item --> ' +
                '</div> ' +
                '</div></article>');
        });
    });

    $commentForm.show();
});

$("body").on("click", ".textarea-ok, .textarea-cancel", function(){
    commentsFetched = false;
    $('.comment-form').hide();
});
