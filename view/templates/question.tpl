<title>{$question['title']}</title>
<div class="clearfix qa-main">
    {include file="common/messages.tpl"}
    <div class="home-left-inner">
        <div class="col-md-8">
            <div class="qa-part-q-view">
                <div class="qa-q-view question question-info-container" data-id="{$question['publicationid']}">
                    <div class="question-head">
                        <div class="big-s-avatar avatar">
                            <a href="">

                                <img width="60"
                                     height="60" class="qa-avatar-image" src="{$photo}">
                            </a>
                        </div>
                        <div class="no-overflow">


                            <div class = "options pull-right " style = "margin-bottom:5px;">
                                <br class="clearfix">
                                {include file="question_partials/vote_panel.tpl"}
                            </div>
                            <h2 class="question-title">
                                {$question['title']}
                            </h2>


                            <div class="question-meta">
                                {if $question['solved_date']}
                                    <button class="post-status open">Solved</button>
                                {else}
                                    <button class="question-solved post-status closed">Not Solved</button>
                                {/if}
                                <span class="q-view-a-count">{$question['answers_count']} Answers</span>
                                <span class="icon-eye-open q-view-v-count">{$question['views_counter']} Views</span>
                                <a class="cat-in fa fa-folder" href={categoryQuestionsUrl($category)}>{$question['category']}</a>
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
                                                asked
                                                <span class="qa-q-item-when">
                                                    <span class="qa-q-item-when-data"><span class="published"><span class="value-title" title="2016-06-06T11:13:09+0000"></span>{$question['creation_date']}</span></span>
                                                </span>
                                                <span class="qa-q-item-who">
                                                    <span class="qa-q-item-who-pad">by </span>
                                                    <span class="qa-q-item-who-data"><span class="vcard author"><a style="display: inline;" href={profileUrl($question['userid'])} class="qa-user-link">{$question['username']}</a></span></span>
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
                                            <div class="post-button clearfix">
                                                <a href="{editQuestionUrl($question['publicationid'])}" class = "btn {if !$isMine}hidden{/if}">Edit</a>

                                                <div class="post-button clearfix">
                                                    <button class="btn show-textarea"
                                                            title="Add a comment on this answer"
                                                            type="button"
                                                            data-answer="{$answer['answerid']}"
                                                            data-question="{$question['publicationid']}"
                                                            data-type="question">{$answer['total_comments']} Comments</button>
                                                    <div class="textarea">
                                                        {include file="question_partials/comment_form.tpl"}
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <h3 class="answers-label">{$question['answers_count']} Answers</h3>

                                        <div class="qa-a-list-item entry answer">
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
                </div>
            </div>
        </div>

        <div class="col-md-4 pull-right">
            <div id="home-right-position">

                <div class="widget cs_related_questions">
                    <h3 class="widget-title">Related questions</h3>
                    <div class="ra-rq-widget">
                        <ul>
                            {foreach $related_questions as $related_question}
                                <li><div class="avatar" data-id="4" data-handle="Smith"><a class="qa-avatar-link"><img src="{$related_question['user_photo']}" width="30" height="30" class="qa-avatar-image" alt=""></a></div>
                                    <div class="post-content">
                                        <a class="title" href="{questionUrl($related_question['publicationid'])}">{$related_question['title']}</a>
                                        <div class="meta">
                                            <span>{$related_question['answers_count']} answers</span>
                                            <span class="time fa fa-clock-o">{$related_question['creation_date']}</span>
                                            <span class="vote-count fa fa-thumbs-o-up">{$related_question['votes_count']} votes</span>
                                        </div>
                                    </div>
                                </li>
                            {/foreach}

                        </ul>
                    </div>
                </div>
            </div>

        </div>

    </div>
</div>
{HTML::script('comment.js')}
{HTML::script('question.js')}
{HTML::script('vote.js')}