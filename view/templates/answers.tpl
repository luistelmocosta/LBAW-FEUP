<div class="qa-a-item-main">
    <div class="asker-detail clearfix">
        <div class="asker-avatar avatar"></div>

        <div class="user-info no-overflow">
            <h3 class="asker-name"></h3>
            <p class="asker-point"> <span class="title"></span></p>
        </div>
        {include file="question_partials/vote_panel.tpl"}
        <form method="post" action="">
            <div class="qa-a-selection">
            </div>
            <input name="code" type="hidden">
            <input name="qa_click" value="" type="hidden">
        </form>
    </div>
    <div class="a-item-inner-wrap">
        <form method="post" action="">
            <div class="a-item-wrap">
                <div class="qa-a-item-content">
                    <a name="187"></a><div class="entry-content">{$answer['body']}</div>
                </div>
                <span class="qa-a-item-meta">
                    <a href="../184/how-to-install-this-theme?show=187#a187" class="qa-a-item-what">answered</a>
                    <span class="qa-a-item-when">
                        <span class="qa-a-item-when-data">
                            <span class="published">
                                <span class="value-title" title="">
                                </span>{$answer['creation_date']}</span></span>
                    </span>
                    <span class="qa-a-item-who">
                        <span class="qa-a-item-who-pad">by </span>
                        <span class="qa-a-item-who-data">{$answer['username']}</span>
                    </span>
                </span>
                <div class="post-button clearfix">
                    <button name="a187_doflag" onclick="return qa_answer_click(187, 184, this);" class="btn icon-flag" title="Flag this answer as spam or inappropriate" type="submit">flag</button>
                    <button name="a187_dofollow" class="btn icon-add-answer" title="Ask a new question relating to this answer" type="submit">ask related question</button>
                    <button name="a187_docomment" onclick="return qa_toggle_element('c187')" class="btn icon-chat" title="Add a comment on this answer" type="submit">comment</button>
                </div>
            </div>

            <div class="qa-a-item-c-list" style="display:none;" id="">
                <div class="comment-count icon-comments">0<span>Comments</span></div>
                <div class="comment-items">
                </div>
            </div> <!-- END qa-c-list -->

            <input name="code" value="0-1489600293-0c8505c3a885e0a52578dc109fb02255a05018b6" type="hidden">
            <input name="qa_click" value="" type="hidden">
        </form>
        <div class="qa-c-form" id="c187" style="display:none;">
            <div class="asker-avatar no-radius">

            </div>
            <div class="comment-f-wrap">
                <h3>
                    Please <a href="">log in</a> or <a href="../register?to=184%2Fhow-to-install-this-theme">register</a> to add a comment.
                </h3>
            </div>

        </div>

    </div>
</div>