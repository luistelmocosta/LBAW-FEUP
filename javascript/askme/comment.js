

$("#textarea, #textarea-ok").hide(); // or you can have hidden w/ CSS
$("#showarea").click(function(){
    $("#textarea").show();
});
$("#textarea-ok, #cancel").click(function(){
    $("#textarea").hide();
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