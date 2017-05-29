<div class="comment-form">
    <form method="post" name="commentform" action="{$BASE_URL}controller/actions/comments/create_comment_question.php" onsubmit="return validateForm()">
        <textarea name="comment" rows="4" cols="40" class="qa-form-tall-text"></textarea>
        <input type="hidden" name="answerid" value="{$answer['answerid']}" />
        <input type="hidden" name="questionid" value="{$question['publicationid']}" />
        <button type="submit" class="textarea-ok">Add Comment</button>
    </form>
</div>