$('.comment-form').hide();
var commentsFetched = false;

$("body").on("click", ".show-textarea", function(){
    console.log("teste");
    var answerid = $(this).data('answer');
    var type = $(this).data('type');
    var questionid = $(this).data('question');
    var $commentForm = $(this).parent().find('.comment-form').first();
    console.log("teste");
    $.getJSON("/controller/api/comments/comment.php", {
        answerid : answerid,
        questionid : questionid,
        type : type
    }, function (data) {
        $commentForm.find('article').remove();
        console.log("AID " + answerid);
        console.log("Data" + data.length);
        $.each(data, function(i, comment) {
            console.log("Comment:" + comment);
            $commentForm.append('<article class="tweet-data">' +
                '<div class="comment-items">' +
                '<div class="qa-c-list-item  hentry comment" id="c3574">' +
                '<div class="asker-avatar">' +
                '<a href="../../../controller/pages/users/profile.php?userid=' +
                comment.userid +
                '">' +
                '<img width="40" height="40" src="' +
                comment.user_photo +
                '"></a>' +
                '</div>' +
                '<div class="qa-c-wrap">' +
                '<span class="qa-c-item-meta">' +
                'commented ' +
                comment.creation_date +
                ' by ' +
                '<a style="display: inline" href="../../../controller/pages/users/profile.php?userid=' +
                comment.userid +
                '" class="qa-user-link url nickname">' +
                comment.username +
                '</a> ' +
                '<span class="qa-c-item-who-points"> ' +
                '<span class="qa-c-item-who-points-pad">(</span><span class="qa-c-item-who-points-data">' +
                comment.user_ranking +
                '</span><span class="qa-c-item-who-points-pad"> points)</span> ' +
                '</span> ' +
                '</span> ' +
                '</span> ' +
                '<div class="qa-c-item-content" style="color: #2d2727; font-size: 13px"> ' +
                '<a name="3574"></a>' +
                '<div class="entry-content">' +
                comment.body +
                '</div> ' +
                '</div> ' +
                '<div class="comment-edit-form">' +
                '<form method="post" action="/controller/actions/comments/edit_comment.php">' +
                (comment.IsMine ?
                    '<button class = "edit-comment btn" type="button">Edit</button>' +
                    ''
                    : '') +
                '</form>' +
                '</div> ' +
                '</div> <!-- END qa-c-item --> ' +
                '</div>' +
                '</div>' +
                '<input class="commentid" type="hidden" value="' +
                comment.publicationid +
                '" />' +
                '<input class="questionid" type="hidden" value="' +
                comment.questionid +
                '" />' +
                '</article>');
        });
    });

    $commentForm.show();
});

$("body").on("click", ".textarea-ok, .textarea-cancel", function(){
    commentsFetched = false;
    $('.comment-form').hide();

});

$("body").on("click", ".edit-comment", function(e){
    e.stopPropagation();
    var parent = $(this).parent();
    var content = parent.parent().parent().find('.entry-content');
    var info = content.parent().parent().parent().parent().parent();
    var body = content.text();
    var id = info.find('.commentid').val();
    var questionid = info.find('.questionid').val();

    console.log(body);
    console.log(id);
    console.log(questionid);
    console.log(info);
    var editableText = $('<div class="comment-form">' +
        '<form method="post" action="/controller/actions/comments/edit_comment.php">' +
        '<textarea name="comment" rows="4" cols="40" class="qa-form-tall-text">' +
        body +
        '</textarea>' +
        '<input type="hidden" name="commentid" value="' +
        id +
        '" />' +
        '<input type="hidden" name="questionid" value="' +
        questionid +
        '" />' +
        '<button type="submit" class="textarea-ok">Edit Comment</button>' +
        '</form>' +
        '</div>');
    console.log("Hello");
    parent.replaceWith(editableText);




});


