<div id="site-body" class="container">
    <div class="clearfix qa-main">
        <div class="col-sm-12 list-c">
            <h1>Edit Question</h1>
            <br>
            <div class="qa-part-form">
                <form name="ask" method="post" action= "{$BASE_URL}controller/actions/questions/create_question.php">
                    <table class="qa-form-tall-table">
                        <tbody>
                        <tr>
                            <td class="qa-form-tall-label">
                                Title
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-tall-data">
                                <input name="title" id="title" autocomplete="off" onchange="" type="text" value="{old('title', $question['title'])}" class="qa-form-tall-text">
                            </td>
                        </tr>

                        <tr>
                            <td class="qa-form-tall-label">
                                Category
                                <span id="category_0_sub">
                                    <select name="category" id="category_1" onchange="" class="qa-form-tall-select">
                                        {foreach $categories as $category }
                                            <option value="{old('category', $question['category'])}" selected>{old('category', $category)}</option>
                                        {/foreach}

                                    </select>
                                </span>
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
                                <textarea name="editor1">{old('body', $question['body'])}</textarea>
                                <script>
                                    CKEDITOR.replace( 'editor1' );
                                </script>

                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-tall-label">
                                Tags - use comma (,) as a separator
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-tall-data">
                                <input name="tags" id="tags" autocomplete="off" type="text" value="{$tags}"
                                       class="qa-form-tall-text">
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

