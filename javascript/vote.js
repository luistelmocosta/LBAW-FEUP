$(document).ready(function () {

    window.setInterval(function () {
        $('body').find('.count.vote-count').each(function (index) {
            var current = $(this);
            var url = current.data('url');
            var parent = current.parent();
            var voteType = parent.data('type');
            var voteId = parent.data('id');
            $.get(url + '?id=' + voteId, function (data) {

                data = JSON.parse(data);
                if(data.rating.get_publication_rating === null)
                    current.html(0);
                else
                    current.html(data.rating.get_publication_rating)



            });
        });
    }, 1000);

    $(".increment.up").on('click', function (e) {
        e.stopPropagation();
        console.log("voting up");
        var parent = $(this).parent();
        console.log(parent);
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