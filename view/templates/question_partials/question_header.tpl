<div class="question-head">
    <div class="big-s-avatar avatar">
        <a href="">
            <img src="http://www.gravatar.com/avatar/86017f9989f66cb2e36be0714634acaa?s=70">
        </a>
    </div>
    <div class="no-overflow">
        <h2 class="question-title">
            <div class="enabled voting clearfix voting-vertical qa-voting-net" id="voting_187">
                <a title="" class=" fa fa-thumbs-up enabled vote-up enabled" data-original-title="Click to vote up"></a>
                <span class="count">{$question['upvotes']}</span>
                <a title="" class=" fa fa-thumbs-down enabled vote-down enabled" data-original-title="Click to vote down"></a>
                <span class="count">{$question['down_votes']}</span>
            </div>
            <div class = "options pull-right" style = "margin-bottom:5px;">
                <button class = "btn btn-primary btn-xs edit-question" data-url = "{editQuestionUrl('')}">Edit</button>
                <button class = "btn btn-success btn-xs trigger-question-solved{if $question['solved']} hidden{/if}"
                        data-url="{questionSolvedUrl('')}">Mark as solved</button>
            </div>
            {$question['title']}
        </h2>


        <div class="question-meta">
            {if $question['solved_date']}
                <span class="post-status open">Solved</span>
            {else}
                <span class="post-status closed">Not Solved</span>
            {/if}


            <span class="q-view-a-count">{$question['answers_count']} Answers</span>
            <span class="icon-eye-open q-view-v-count">{$question['views_counter']} Views</span>
            <a class="cat-in fa fa-folder" href="">{$question['category']}</a>
        </div>
    </div>

    <div class="qa-q-view-main">
        <div class="q-cont-right">
            <div class="qa-q-view-wrap">
                <div class="qa-q-view-inner">
                    <div class="clearfix">
                        <div class="qa-q-view-content">
                            <div class="entry-content">{$question['body']}</div>
                        </div>
                    </div>



                    <div class="qa-post-meta">
                                            <span class="qa-q-item-meta">
                                                <a href="" class="qa-q-item-what">asked</a>
                                                <span class="qa-q-item-when">
                                                    <span class="qa-q-item-when-data"><span class="published"><span class="value-title" title="2016-06-06T11:13:09+0000"></span>{$question['creation_date']}</span></span>
                                                </span>
                                                <span class="qa-q-item-who">
                                                    <span class="qa-q-item-who-pad">by </span>
                                                    <span class="qa-q-item-who-data"><span class="vcard author"><a href="../user/cusatxpress" class="qa-user-link url nickname">{$question['username']}</a></span></span>
                                                </span>
                                            </span>
                        <div class="question-tags">
                            <h3 class="tags-label">Tags</h3>
                            <ul class="tags-tag-list">
                                {foreach $tags as $tag}
                                    <li><a href="" class="widget-tag">{$tag['name']}</a></li>
                                {/foreach}
                            </ul>
                        </div>
                    </div>

                    <h3 class="answers-label">{$question['answers_count']} Answers</h3>

                    <div class="qa-a-list-item hentry answer">
                        {foreach $answers as $answer}
                            {include file="answers.tpl"}
                        {/foreach}
                        <!-- END qa-a-item-main -->
                    </div>

                    <div class="answer-form">
                        Your answer:


                        <div class="qa-part-form">
                            <form name="ask" method="post" action="{$BASE_URL}controller/actions/answers/create_answer.php">
                                <table class="qa-form-tall-table">
                                    <tbody>
                                    <tr>
                                        <td class="qa-form-tall-data">
                                            <textarea name="editor1"></textarea>
                                            <script>
                                                CKEDITOR.replace( 'editor1' );
                                            </script>

                                        </td>
                                    </tr>
                                    </tbody>
                                    <tbody><tr>
                                        <td colspan="1" class="qa-form-tall-buttons">
                                            <input onclick="qa_show_waiting_after(this, false);" value="Answer" title="" type="submit" class="qa-form-tall-button qa-form-tall-button-answer">
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>

                                <div class = "form-group ">
                                    <input type="hidden" name = "questionid" value="{$question['publicationid']}">
                                </div>

                            </form>
                        </div>


                    </div>

                </div>
            </div>
            </form>

        </div> <!-- END qa-q-view-main -->
    </div>
</div>