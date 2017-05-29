$(document).ready(function () {

    window.setInterval(function () {
        $('body').find('.accept.up').each(function (index) {
            var current = $(this);
            var info = current.parent().parent();
            var url = info.data('refresh');
            var parent = current.parent();
            var answerID = info.data('answer');
            $.get(url + '?id=' + answerID, function (data) {
                data = JSON.parse(data);

                if(data.rating.is_answer_accepted === 0) {
                    current.removeClass('text-success');
                    current.prop('title', 'Accept this answer');
                }

                else {
                    current.addClass('text-success');
                    current.prop('title', 'Unnaccept this answer');

                }




            });
        });
    }, 1000);

    $(".accept.up").off('click').on('click', function (e) {
        e.stopPropagation();
        var parent = $(this).parent().parent();
        var url = parent.data('url');
        var qid = parent.data('question');
        var aid = parent.data('answer');
        var current = $(this);

        $.get(url + '?question=' + qid + '&answer=' + aid, function (data) {
            data = $.parseJSON(data);
            if (data.status) {
                parent.find('.question-solved-status').removeClass('text-danger').addClass('text-success');
                parent.find('.question-solved-status').find('span').html('Solved');
                //current.addClass('hidden');
            }
        });
    });

});