$(document).ready(function () {

    $(".question-solved").on('click', function () {
        console.log("Hello");

        $("body").on('click', '.edit-question', function () {
            var url = $(this).data('url');
            var parent = $(this).closest('.question-info-container');
            var id = parent.data('id');
            var current = $(this);

            $.get(url + id, function (data) {
                data = $.parseJSON(data);
                if (data.status) {
                    parent.find('.question-solved-status').removeClass('text-danger').addClass('text-success');
                    parent.find('.question-solved-status').find('span').html('Solved');
                    current.addClass('hidden');
                }
            });
        });
    });
});

