$(document).ready(function () {
    $(".increment.up").on('click', function (e) {
        e.stopPropagation();
        console.log("voting up");
        var parent = $(this).parent();
        var voteId = parent.data('id');
        console.log(voteId);
        var url = parent.data('url');
        console.log(url);
        $.get(url + '?id=' + voteId + '&value=1', function (data) {
            data = JSON.parse(data);
            setVotingStatus(parent, data.result);
        });


    });

    $(".increment.down").on('click', function (e) {
        e.stopPropagation();
        console.log("voting down");
        var parent = $(this).parent();
        var voteType = parent.data('type');
        var voteId = parent.data('id');
        var url = parent.data('url');

        $.get(url + '?id=' + voteId + '&value=-1', function (data) {
            data = JSON.parse(data);
            setVotingStatus(parent, data.result);
        });
    });

});

function setVotingStatus(object, result) {
    object.find('.increment').removeClass('active');

    if (result == 1) {
        object.find('.increment.up').addClass('active');
    }

    if (result == -1) {
        object.find('.increment.down').addClass('active');
    }
}