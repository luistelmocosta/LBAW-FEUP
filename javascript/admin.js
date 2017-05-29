$(document).ready(function () {

    siteStats();
    usersStats();
    behaviourStats();


    //DEL QUEST

    $(".questTable button").click(function (e) {
        e.preventDefault();
        $.post("../../api/admin/delete_publication.php", { id: $(this).closest('tr').attr('id') }, function() {
            window.location.reload();
        });
    });


    //BAN USER

    $(".usersTable #ban").click(function (e) {
        e.preventDefault();
        var checkbox = $(this);

        var dateToday = new Date();
        var banSpan = $("#banSpan").datepicker({
            defaultDate: "+1w",
            minDate: dateToday,
            dateFormat: 'yy-mm-dd'
        });

        if(checkbox.is(':checked')){
            //BAN
            $("#banMsgModal #subBtn").click(function(e){
                var reasonMsg = $('textarea#banMsg').val();
                $.post("../../api/admin/ban_user.php", {
                    uid: checkbox.closest('tr').attr('id'),
                    reasonMsg: reasonMsg,
                    banSpan: banSpan.val()
                }, function () {
                    checkbox.attr("checked", true);
                });

            });
        }
        else {
            //UNBAN
            $.post("../../api/admin/un_ban_user.php", {uid: $(this).closest('tr').attr('id')}, function () {
                checkbox.attr("checked", false);
            });
        }

    });


    //WARN USER

    $('.usersTable #triggerModal').click(function(){
        var targetID = $(this).closest('tr').attr('id');

        $('.usersTable #subBtn').click(function(e){
            $.post("../../api/admin/warn_user.php", { uid: targetID, reasonMsg: $('textarea#warnMsg').val()}, function() {
                $('.modal-body').find('textarea,input').val('');
            });
        });
    });


    //PROMOTE USER

    $(function() {

        $(".usersTable #slider-range").slider({
            range: "min",
            min: 1,
            max: 3,
            create: function () {
                var val;
                if($(this).closest('.usersTable').find('#permLabel').html() == "admin")
                    val = 3;
                else if($(this).closest('.usersTable').find('#permLabel').html() == "mod")
                    val = 2;
                else if($(this).closest('.usersTable').find('#permLabel').html() == "reg")
                    val = 1;

                $(this).slider( "option", "value", val);
            },
            slide: function (event, ui) {
                var targID = $(this).closest(".usersTable").attr("id");
                var perm = ui.value;

                $.post("../../api/admin/changeUserPerm.php", { uid: targID, perm: perm}, function() {
                    window.location.reload();
                });

            }
        });

    });

});

/*

 SEARCH USERS

 */

$('#search-users').on('click' ,function(e) {
    e.preventDefault();
    var search = $('#search-user').val();
    var usersTable = $('#users');
    var pagination = $('#pagination-users');
    var selector = $(this).parent().parent().parent().parent();
    console.log("Searched user: " + search);
    $.getJSON("../../api/admin/search_user.php", {
        search : search
    }, function(data) {
        if (data.length === 0) {
            selector.append(
                '<br class="clearfix"></div>' +
                '<br class="clearfix"></div>'
            );
        }
        usersTable.remove();
        pagination.remove();
        $.each(data, function(i, user) {
            selector.append('<div class="col-sm-12"></div>'+
                '<div class="table-responsive col-md-12">' +
                '<table id="users" class="table table-bordered table-responsive">' +
                '<tbody> ' +
                '<th>Username</th> ' +
                '<th>Role</th> ' +
                '<th>Email</th> ' +
                '<th class="info-tab" style="text-align: center">Info</th> ' +
                '<th class="warn-tab " style="text-align: center">Warn</th> ' +
                '<th class="ban-tab" style="text-align: center">Ban</th> ' +
                '<th class="promote-tab" style="text-align: center">Promote</th>' +
                '<tr class="usersTable" id=' +
                user.userid +
                '> ' +
                '<td> ' +
                user.username + '</td> ' +
                '<td id="usrRole">' +
                user.rolename +
                '</td> ' +
                '<td>' +
                user.email +
                '</td> ' +
                '<td style="text-align: center"> ' +
                '<a <span class="glyphicon glyphicon-info-sign" href="../users/profile.php?userid=' +
                user.userid +
                '"></span></a>' +
                '</td>' +
                '<td id="warnUsr" style="text-align: center"> ' +
                '<button id="triggerModal" type="button" class="btn-default btn-xs" data-toggle="modal" data-target="#warnMsgModal" style="font-size: 15px"> ' +
                '<i class="glyphicon glyphicon-warning-sign"></i> ' +
                '</button> ' +
                '<div class="modal fade" id="warnMsgModal" role="dialog"> ' +
                '<div class="modal-dialog modal-md"> ' +
                '<div class="modal-content"> ' +
                '<div class="modal-header"> ' +
                '<button type="button" class="close" data-dismiss="modal">&times;</button>' +
                '<h4 class="modal-title">Warning Message</h4>' +
                '</div> ' +
                '<form id="warnUsr" name="wrnUsr" method="post" action=""> ' +
                '<div class="modal-body"> ' +
                '<textarea id="warnMsg" name="msg"></textarea> ' +
                '</div> ' +
                '<div class="modal-footer"> ' +
                '<button id="subBtn" type="submit" class="btn-default btn-xs">Warn</button> ' +
                '</div> ' +
                '</form> ' +
                '</div> ' +
                '</div> ' +
                '</div> ' +
                '</td> ' +
                '<form name="banUsr" method="post" action=""> ' +
                '<td id="banUsr" style="text-align: center"> ' +
                '<label class="switch">' +
                (user.bancount > 0 ?
                    '<input id="ban" type="checkbox" checked="checked">' +
                    ''
                    :
                    '<input id="ban" type="checkbox" data-toggle="modal" data-target="#banMsgModal">') +
                '<div class="slider round"></div> ' +
                '</label> ' +
                '</form> ' +
                '<div class="modal fade" id="banMsgModal" role="dialog"> ' +
                '<div class="modal-dialog modal-md"> ' +
                '<div class="modal-content"> ' +
                '<div class="modal-header"> ' +
                '<button type="button" class="close" data-dismiss="modal">&times;</button> ' +
                '<h4 class="modal-title">Ban Message</h4> ' +
                '</div> ' +
                '<form id="banUsr" name="bnUsr" method="post" action=""> ' +
                '<div class="modal-body"> ' +
                '<textarea id="banMsg" name="msg"></textarea>' +
                'Until Date: ' +
                '<input type="text" placeholder="Number of days" id="banSpan"> ' +
                '</div> ' +
                '<div class="modal-footer"> ' +
                '<button id="subBtn" type="submit" class="btn-default btn-xs">Ban</button> ' +
                '</div> ' +
                '</form> ' +
                '</div> ' +
                '</div> ' +
                '</div> ' +
                '</td> ' +
                '<form name="promUsr" method="post" action="/controller/api/admin/prom_user.php"> ' +
                '<td id="promUsr" style="text-align: center"> ' +
                '<label id="permLabel" for="perm">' +
                user.rolename + '</label><div id="slider-range"></div> ' +
                '</td> ' +
                '</form> ' +
                '</tr>' +
                '</tbody> ' +
                '</table>'+
                '</div>'
            );

            $(".usersTable #ban").click(function (e) {
                e.preventDefault();
                var checkbox = $(this);

                var dateToday = new Date();
                var banSpan = $("#banSpan").datepicker({
                    defaultDate: "+1w",
                    minDate: dateToday,
                    dateFormat: 'yy-mm-dd'
                });

                if(checkbox.is(':checked')){
                    //BAN
                    $("#banMsgModal #subBtn").click(function(e){
                        var reasonMsg = $('textarea#banMsg').val();
                        $.post("../../api/admin/ban_user.php", {
                            uid: checkbox.closest('tr').attr('id'),
                            reasonMsg: reasonMsg,
                            banSpan: banSpan.val()
                        }, function () {
                            checkbox.attr("checked", true);
                        });

                    });
                }
                else {
                    //UNBAN
                    $.post("../../api/admin/un_ban_user.php", {uid: $(this).closest('tr').attr('id')}, function () {
                        checkbox.attr("checked", false);
                    });
                }

            });


            //WARN USER

            $('.usersTable #triggerModal').click(function(){
                var targetID = $(this).closest('tr').attr('id');

                $('.usersTable #subBtn').click(function(e){
                    $.post("../../api/admin/warn_user.php", { uid: targetID, reasonMsg: $('textarea#warnMsg').val()}, function() {
                        $('.modal-body').find('textarea,input').val('');
                    });
                });
            });


            //PROMOTE USER

            $(".usersTable #slider-range").slider({
                range: "min",
                min: 1,
                max: 3,
                create: function () {
                    var val;
                    if($(this).closest('.usersTable').find('#permLabel').html() == "admin")
                        val = 3;
                    else if($(this).closest('.usersTable').find('#permLabel').html() == "mod")
                        val = 2;
                    else if($(this).closest('.usersTable').find('#permLabel').html() == "reg")
                        val = 1;

                    $(this).slider( "option", "value", val);
                },
                slide: function (event, ui) {
                    var targID = $(this).closest(".usersTable").attr("id");
                    var perm = ui.value;

                    $.post("../../api/admin/changeUserPerm.php", { uid: targID, perm: perm}, function() {
                        window.location.reload();
                    });

                }
            });
        });
    });
});

/*

 SEARCH QUESTIONS

 */

$('#search-questions').on('click' ,function(e)
{
    e.preventDefault();
    var search = $('#search-question').val();
    var usersTable = $('#quests');
    var pagination = $('#pagination-quests');
    var selector = $(this).parent().parent().parent().parent();
    console.log("Searched question: " + search);
    $.getJSON("../../api/admin/search_question.php", {
        search : search
    }, function(data) {
        usersTable.remove();
        pagination.remove();
        if (data.length === 0) {
            selector.append(
                '<br class="clearfix"></div>' +
                '<br class="clearfix"></div>'
            );
        } else {

            $.each(data, function(i, question) {

                selector.append('<div class="col-sm-12"></div>'+
                    '<div class="table-responsive col-md-12">' +
                    '<table id="quests" class="table table-bordered table-responsive">' +
                    '<tbody>' +
                    '<th>Title</th>'  +
                    '<th>Author</th>' +
                    '<th style="text-align: center">Info</th>' +
                    '<th style="text-align: center">Delete</th>' +
                    '<tr class="questTable" id=' +
                    question.publicationid +
                    '>' +
                    '<td>' +
                    question.title +
                    '</td>' +
                    '<td>' +
                    question.username +
                    '</td>' +
                    '<td style="text-align: center">' +
                    '<a <span class="glyphicon glyphicon-info-sign" href="../questions/question.php?question=' +
                    question.publicationid +
                    '"></span></a>' +
                    '</td>' +
                    '<form name="delQuest" method="post" action="/controller/api/admin/delete_publication.php">' +
                    '<td id="delQuest" style="text-align: center">' +
                    '<button type="submit" class="btn-default btn-xs" style="font-size: 15px;">' +
                    '<i class="glyphicon glyphicon-remove-circle"></i>' +
                    '</button>' +
                    '</td>' +
                    '</form>' +
                    '</tr> ' +
                    '</tbody> ' +
                    '</table>'+
                    '</div>'
                );
            });

        }

        $(".questTable button").click(function (e) {
            e.preventDefault();
            $.post("../../api/admin/delete_publication.php", { id: $(this).closest('tr').attr('id') }, function() {
                window.location.reload();
            });
        });

    });
});

/*

 SITE STAT CHARTS

 */

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
            labels: ["Quest", "Ans", "Comm", "Uns"],
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
            labels: ["Registered", "Moderators", "Admins"],
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
