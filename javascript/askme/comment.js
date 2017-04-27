

$(".textarea, .textarea-ok").hide();

$("body").on("click", ".showarea", function(){
    $(this).show();
    $(this).stopPropagation();
});

$("body").on("click", ".textarea-ok, .cancel", function(){
    $(this).hide();
});


/*function checkForNewComments() {
 $.getJSON("/controller/api/comments/comment.php", function(data) {
 console.log(data);
 });
 }

 function initCommentReloader() {
 $('#showarea').on('click', 'a', function() {
 $.getJSON("/controller/api/comments/comment.php", {answerid: answerid}, function(data) {
 $.each(data, function(i, comment) {
 console.log(comment.body);
 });
 });
 });
 }*/

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
                '<button name="" onclick="" class="btn icon-flag" title="Flag this comment as spam or inappropriate" type="submit">flag</button>' +
                '<button name="" class="btn icon-answers" title="Reply to this comment" type="submit">reply</button>' +
                '</div>' +
                '<span class="qa-c-item-meta">' +
                '<a href="" class="qa-c-item-what">commented</a>'+
                '<span class="qa-c-item-when">' +
                '<span class="qa-c-item-when-data"><span class="published">' +
                '<span class="value-title" title="2017-04-21T00:27:53+0000">' +
                '</span> 1 day</span></span><span class="qa-c-item-when-pad"> ago</span> ' +
                '</span> ' +
                '<span class="qa-c-item-who"> ' +
                '<span class="qa-c-item-who-pad">by </span> ' +
                '<span class="qa-c-item-who-data"><span class="vcard author">' +
                '<a href="" class="qa-user-link url nickname">' +
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
        });
    });
});