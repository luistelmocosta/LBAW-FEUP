{include file='../common/header.tpl'}

<div class="container" style="margin-top: 2em">

    <h1>Question Details</h1>
    <div class="question_space">
        <div class = "col-sm-12 container-white question-info-container" data-id="">

            <div class = "col-sm-2">
                <span class="pull-right">
                        <i id="like1" class="glyphicon glyphicon-thumbs-up"></i> <div id="like1-bs3"></div>
                        <i id="dislike1" class="glyphicon glyphicon-thumbs-down"></i> <div id="dislike1-bs3"></div>
                    </span>


            </div>
            <div class = "col-sm-10">
                <h3>
                    <a href = "" class = "question-title" data-base-question-url = "">

                    </a>
                </h3>
                <p class = "question-description">
                    <a href = "" class = "question-body" data-base-question-url = "">

                    </a>
                </p>
                <div class = "options pull-right" style = "margin-bottom:5px;">
                    <button class = "btn btn-primary btn-xs edit-question" data-url = "">Edit</button>
                    <button class = "btn btn-success btn-xs trigger-question-solved"
                            data-url="">Mark as solved</button>
                </div>
            </div>

            <div class = "statistics col-sm-12 text-center">
        <span>
            <i class = "glyphicon glyphicon-user"></i>
             <a href = "" class = "question-user" data-url = "">

            </a>
        </span>

                    <span class = "text-success question-solved-status">
                <i class = "glyphicon glyphicon-check"></i>
                <span>Solved</span>
            </span>

                    <span class = "text-danger question-solved-status">
                <i class = "glyphicon glyphicon-check"></i>
                <span>Not Solved</span>
            </span>

                <span>
            <i class = "glyphicon glyphicon-time"></i>
            <span class = "question-updated-at">

            </span>
        </span>
                <span>
            <i class = "glyphicon glyphicon-comment"></i>
            <span class = "question-answers">{$question['number_answers']} answer{if $question['number_answers'] != 1 }s{/if}</span>
        </span>
            </div>
        </div>
    </div>

    <div class="answer_space ">


    </div>


</div>


{include file='../common/footer.tpl'}