$('.comment-form').hide();
var commentsFetched = false;

$("body").on("click", ".show-textarea", function(){

    var answerid = $(this).data('answer');
    var type = $(this).data('type');
    var questionid = $(this).data('question');
    var $commentForm = $(this).parent().find('.comment-form').first();
    console.log(answerid);
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
                '<a>' +
                '<img width="40" height="40" src="' +
                comment.user_photo +
                '"></a>' +
                '</div>' +
                '<div class="qa-c-wrap">' +
                '<span class="qa-c-item-meta">' +
                'commented ' +
                comment.creation_date +
                ' by ' +
                '<a style="display: inline" href="controller/pages/users/profile/' +
                comment.questionid +
                '}" class="qa-user-link url nickname">' +
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

$("body").on("click", ".edit-comment", function(){
    console.log("Hello");
    var parent = $("body").find('article').last();
    var body = parent.find('.entry-content').text();
    var id = parent.find('.commentid').val();
    var questionid = parent.find('.questionid').val();
    console.log(body);
    console.log(id);
    console.log(questionid);
    var parent_parent = $("body").find('article').parent().last();
    parent.remove();
    console.log(parent);
    var button = $(this),
        commentField = $('<div class="comment-form">' +
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
            '</div>'); // create a textarea element

    commentField
    // set the textarea's value to be the saved content, or a default if there is no saved content
        .val(button.data('textContent') || 'This is my comment field\'s text')
        // set up a keypress handler on the textarea
        .keypress(function(e) {
            if (e.which === 13) { // if it's the enter button
                e.preventDefault(); // ignore the line break
                button.data('textContent', this.value); // save the content to the button
                $(this).remove(); // remove the textarea
            }
        }).appendTo(parent_parent); // add the textarea to the document


});


