$(document).ready(function () {

    window.setInterval(function () {
        $('body').find('.accepted.up').each(function (index) {
            var current = $(this);
            console.log(current);
            var url = current.parent().data('refresh');
            console.log(url);
            var parent = current.parent();
            var answerID = parent.data('answer');
            console.log(answerID);
            $.get(url + '?id=' + answerID, function (data) {

                data = JSON.parse(data);

                if(data.rating.solved_date === null)
                    current.removeClass('active');
                else
                    current.addClass('active');



            });
        });
    }, 1000);

    $(".accepted.up").on('click', function (e) {
        e.stopPropagation();
        console.log("Hello");
        var parent = $(this).parent();
        var url = parent.data('url');
        var qid = parent.data('question');
        var aid = parent.data('answer');
        console.log(qid);
        console.log(aid);
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