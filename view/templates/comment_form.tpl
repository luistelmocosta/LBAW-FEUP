<form method="post" action="{$BASE_URL}controller/actions/comments/create_comment.php">
    <textarea id="" name="comment" rows="4" cols="40" class="qa-form-tall-text"></textarea>
    <input value="Add comment" title="" type="submit" class="qa-form-tall-button qa-form-tall-button-comment">
    <input type="hidden" name = "answerid" value="{$answer['answerid']}">
    <input type="hidden" name = "questionid" value="{$question['publicationid']}">
    <input value="Cancel" id="cancel" title="" type="button" class="qa-form-tall-button qa-form-tall-button-comment">
    <button id="textarea-ok" name="ok" type="button" value="Ok">
</form>