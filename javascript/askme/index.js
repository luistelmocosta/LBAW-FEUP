/**
 * Created by luiscosta on 4/19/17.
 */

$(document).ready(function () {
    $(".load-more").on('click', function () {
        var tab = $(this).data('tab');
        var next_page = $(this).data('next-page');
        console.log(next_page);
        console.log(tab);
        $.get($(this).data('url') + '?tab=' + tab + '&page=' + next_page, function (data) {
            addNewQuestions($.parseJSON(data));
        });
        $(this).data('next-page', parseInt(next_page) + 1);
    });
});

function addNewQuestions(objects) {

    $.each(objects, function (i, object) {
        console.log(object);
        var lastItem = $('div.question-col .question-summary:last');
        var newLine = lastItem.clone(true);

        var newObject = newLine.find('.question-info');

        updateTitleAndLink(newObject.find('.summary a'), object);


        lastItem.after(newLine);
    });
}

function updateTitleAndLink(questionTitle, object) {
    questionTitle.attr('href', questionTitle.data('base-question-url') + object.publicationid);
    console.log(object.title);
    questionTitle.html(object.title);
}