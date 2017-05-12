$(document).ready(function () {

    siteStats();
    usersStats();
    behaviourStats();

    $(".questTable button").click(function (e) {
        e.preventDefault();
        $.post("../../api/admin/delete_publication.php", { id: $(this).closest('tr').attr('id') }, function() {
            window.location.reload();
        });
    });

    $(".usersTable #ban").click(function (e) {
        //e.preventDefault();
        var checkbox = $(this);

        if(checkbox.is(':checked')){
            //BAN
            $.post("../../api/admin/ban_user.php", { uid: $(this).closest('tr').attr('id') }, function() {
                checkbox.attr("checked", true);
            });
        }

        else {
            //UNBAN
            $.post("../../api/admin/un_ban_user.php", {uid: $(this).closest('tr').attr('id')}, function () {
                checkbox.attr("checked", false);
            });
        }

    });

});


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

function usersStats() {

    var jsonUrl = "../../../javascript/json/userStatsData.json";

    var usersData = [];

    $.ajax({
        url: jsonUrl,
        dataType: 'json',
        async: false,
        success: function(data) {
            usersData = data;
        }
    });

    var ctx = document.getElementById("usersStats");

    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ["Registered", "Editors", "Admins"],
            datasets: [{
                data: usersData,
                backgroundColor: [
                    'rgba(255, 64, 64, 1)',
                    'rgba(64, 64, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderColor: [
                    'rgba(255,99,132,1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    },
                    gridLines: {
                        display: false
                    }
                }],
                xAxes: [{
                    gridLines: {
                        display: false
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

function behaviourStats() {

    var jsonUrl = "../../../javascript/json/behaviourStatsData.json";

    var behaviourData = [];

    $.ajax({
        url: jsonUrl,
        dataType: 'json',
        async: false,
        success: function(data) {
            behaviourData = data;
        }
    });

    var ctx = document.getElementById("behaviourStats");

    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ["Mod. Regist", "Warnings", "Bans"],
            datasets: [{
                data: behaviourData,
                backgroundColor: [
                    'rgba(255, 64, 64, 1)',
                    'rgba(64, 64, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderColor: [
                    'rgba(255,99,132,1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    },
                    gridLines: {
                        display: false
                    }
                }],
                xAxes: [{
                    gridLines: {
                        display: false
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
