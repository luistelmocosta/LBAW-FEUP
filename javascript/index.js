$(document).ready(function () {
    $(".loadMore").on('click', function () {
        var tab = $(this).data('tab');
        var next_page = $(this).data('next-page');
        console.log(next_page);
        $.get($(this).data('url') + '?tab=' + tab + '&page=' + next_page, function (data) {
            addNewQuestions($.parseJSON(data), tab);
        });
        $(this).data('next-page', parseInt(next_page) + 1);
    });

    siteStats();
});

function addNewQuestions(objects, tab) {

    $.each(objects, function (i, object) {
        console.log(tab);
        var lastItem = $(".question-col" + "#" + tab + "> .question-summary").last();
        var newLine = lastItem.clone(true);

        var newObject = newLine.find('.question-info');

        updateTitleAndLink(newObject.find('.summary a'), object);
        updateCreationDate(newObject.find('.question-updated-at'), object);
        updateQuestionAnswers(newObject.find('.question-answers'), object);
        updateAnswerCount(newObject.find('.answers-count'), object);
        updateViewsCount(newObject.find('.views-count'), object);
        updateVotesCount(newObject.find('.votes-count'), object);
        updateSolvedStatus(newObject.find('.status'), object);

        lastItem.after(newLine);
    });
}

function updateAnswerCount(viewsCount, object) {
    viewsCount.html(object.answers_count);
}

function updateSolvedStatus(viewsCount, object) {
    if(object.solved_date) {
        viewsCount.attr('class', 'status answered-accepted');
        console.log(viewsCount);
    } else {
        viewsCount.attr('class', 'status answer-selected');
    }
}

function updateViewsCount(viewsCount, object) {
    viewsCount.html(object.views_counter);
}

function updateVotesCount(viewsCount, object) {
    viewsCount.html(object.votes_count);
}

function updateCreationDate(questionSolved, object) {
    questionSolved.html(object.creation_date);
}

function updateQuestionAnswers(questionAnswers, object) {
    questionAnswers.html(object.answers_count);
}

function updateTitleAndLink(questionTitle, object) {
    questionTitle.attr('href', questionTitle.data('base-question-url') + object.publicationid);
    console.log(object.title);
    questionTitle.html(object.title);
}

function siteStats() {
    var jsonUrl = "../../../javascript/json/siteStatsData.json";

    var siteData=[];

    $.ajax({
        url: jsonUrl,
        dataType: 'json',
        async: false,
        success: function(data) {
            siteData = data;
        }
    });

    var ctx = document.getElementById("siteStats");

    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ["Questions", "Answers", "Comments", "Unsolved"],
            datasets: [{
                data: siteData,
                backgroundColor: [
                    'rgba(255, 64, 64, 1)',
                    'rgba(64, 64, 255, 1)',
                    'rgba(255, 159, 64, 1)',
                    'rgba(64, 220, 64, 1)'
                ],
                borderColor: [
                    'rgba(255,99,132,1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 159, 64, 1)',
                    'rgba(75, 192, 192, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    },
                    gridLines: {
                        display:false
                    }
                }],
                xAxes: [{
                    gridLines: {
                        display:false
                    }
                }]

            },
            legend: {
                display: false
            },
            responsive: false
        }
    });
}