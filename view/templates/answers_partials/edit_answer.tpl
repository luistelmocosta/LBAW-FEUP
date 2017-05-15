<title>Edit Question</title>
<div id="site-body" class="container">
    <div class="clearfix qa-main">
        <div class="col-sm-12 list-c">
            <h1>Edit Answer</h1>
            <br>
            <div class="qa-part-form">
                <form name="ask" method="post" action= "{$BASE_URL}controller/actions/answers/edit_answer.php">
                    <table class="qa-form-tall-table">
                        <tbody>
                        <tr>
                            <td class="qa-form-tall-label">
                                Question Title
                            </td>
                        </tr>
                        <input type = "hidden" name = "answerid" value = "{$answer['answerid']}">
                        <input type = "hidden" name = "questionid" value = "{$answer['questionid']}">
                        <tr>
                            <td class="qa-form-tall-data">
                                <a>{old('title', $answer['title'])}</a>
                            </td>

                        </tr>

                        <tr>
                            <td class="qa-form-tall-data">
                                <div class="qa-form-tall-note">
                                    <div id="category_note"></div></div>
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-tall-label">
                                Description:

                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-tall-data">
                                <textarea name="editor1">{old('body', $answer['body'])}</textarea>
                                <script>
                                    CKEDITOR.replace( 'editor1' );
                                </script>

                            </td>
                        </tr>
                        </tbody>
                        <tbody><tr>
                            <td colspan="1" class="qa-form-tall-buttons">
                                <input onclick="qa_show_waiting_after(this, false);" value="Ask Question" title="" type="submit" class="qa-form-tall-button qa-form-tall-button-ask">
                            </td>
                        </tr>
                        </tbody>
                    </table>

                </form>
            </div>
        </div>
    </div>
</div>

