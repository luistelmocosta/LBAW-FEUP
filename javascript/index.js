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

    siteStatus();
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

function siteStatus() {
    var ctx = document.getElementById("siteStatus");

    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ["Questions", "Answers", "Comments", "Unanswered"],
            datasets: [{
                data: [15, 10, 3, 5],
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