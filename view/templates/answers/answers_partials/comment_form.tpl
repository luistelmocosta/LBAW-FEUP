<div class="comment-form">
    <form method="post" name="answercommentform" action="{$BASE_URL}controller/actions/comments/create_comment.php" onsubmit="return validateAnswerForm()">
        <textarea name="comment" rows="4" cols="40" class="qa-form-tall-text"></textarea>
        <input type="hidden" name="answerid" value="{$answer['answerid']}" />
        <input type="hidden" name="questionid" value="{$question['publicationid']}" />
        <button type="submit" class="textarea-ok">Add Comment</button>
    </form>
</div>