$(document).ready(function () {
    $("body").on('click', '.edit-question', function () {
        var url = $(this).data('url');
        var parent = $(this).closest('.question-info-container');
        var id = parent.data('id');

        window.location.href = url + id;
    });
});