/**
 * Created by luiscosta on 4/19/17.
 */

$(document).ready(function () {
    $(".load-more").on('click', function () {
        var tab = $(this).data('tab');
        var next_page = $(this).data('next-page');
        console.log(next_page);
        console.log(tab);
        /*$.get($(this).data('url') + '?tab=' + tab + '&page=' + next_page, function (data) {
         addNewQuestions($.parseJSON(data));
         });*/
        $.getJSON("/controller/api/questions/load_more_questions.php", {
            tab : tab,
            page : next_page
        }, function (data) {
            $.each(data, function(i, question) {
                console.log(question);
                $('#recent_questions').after('<div class="question-summary narrow">' +
                    '<div class="col-md-12">' +
                    '<div class="votes">' +
                    '<div class="mini-counts"><span title="7 votes">' +
                    '</span></div>' +
                    '<div>votes</div>' +
                    '</div>' +
                    '<div class="status answered-accepted title="one of the answers was accepted as the correct answer"> ' +
                    '<div class="mini-counts"><span title="1 answer">' +
                    question.answers_count +
                    '</span></div>' +
                    '<div>answer</div>' +
                    '</div>' +

                    '<div class="views"> ' +
                    '<div class="mini-counts"><span title="140 views">' +
                    question.views_counter +
                    '</span></div> ' +
                '<div>views</div> ' +
                '</div>' +
                    '<div class="summary"> ' +
                    '<h3>' +
                    '<a href="" class="question-hyperlink" style="font-size: 15px; line-height: 1.4; margin-bottom: .5em;">' +
                    question.title +
                    '</a>' +
                    '</h3>' +
                    '</div>' +
                    '' +
                    '' +
                    '' +
                    '' +
                    '' +
                    '' +
                    '' +
                    '' +
                    '' +
                    '' +
                    '' +
                    ''


                );
            });
        });
    });
});