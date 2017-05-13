$(document).ready(function () {

    window.setInterval(function () {
        $('body').find('.accepted.up').each(function (index) {
            var current = $(this);
            var url = current.parent().data('refresh');
            var parent = current.parent();
            var answerID = parent.data('answer');
            $.get(url + '?id=' + answerID, function (data) {

                data = JSON.parse(data);

                if(data.rating.is_answer_accepted === 0)
                    current.removeClass('active');
                else
                    current.addClass('active');



            });
        });
    }, 1000);

    $(".accepted.up").off('click').on('click', function (e) {
        e.stopPropagation();
        var parent = $(this).parent();
        var url = parent.data('url');
        var qid = parent.data('question');
        var aid = parent.data('answer');
        var current = $(this);

        $.get(url + '?question=' + qid + '&answer=' + aid, function (data) {
            console.log("Reading...");
            data = $.parseJSON(data);
            console.log(data);
            if (data.status) {
                parent.find('.question-solved-status').removeClass('text-danger').addClass('text-success');
                parent.find('.question-solved-status').find('span').html('Solved');
                //current.addClass('hidden');
            }
        });
    });

});