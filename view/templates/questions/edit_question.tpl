<title>Edit Question</title>
<div id="site-body" class="container">
    <div class="clearfix qa-main">
        <div class="col-sm-12 list-c">
            <h1 align="center">Edit Question</h1>
            <br>
            <div class="qa-part-form">
                <form name="ask" method="post" action= "{$BASE_URL}controller/actions/questions/edit_question.php">
                    <table class="qa-form-tall-table">
                        <tbody>
                        <tr>
                            <td class="qa-form-tall-label">
                                <h1 class="page-title">
                                    Title
                                </h1>
                            </td>
                        </tr>
                        <input type = "hidden" name = "questionid" value = "{$question['publicationid']}">
                        <tr>
                            <td class="qa-form-tall-data">
                                <input name="title" id="title" autocomplete="off" onchange="" type="text" value="{old('title', $question['title'])}" class="qa-form-tall-text">
                            </td>

                        </tr>

                        <tr>
                            <td class="qa-form-tall-label">
                                <h1 class="page-title">
                                    Category
                                </h1>
                                <span id="category_0_sub">
                                    <select name="category" id="category_1" onchange="" class="qa-form-tall-select">
                                        {foreach $categories as $category }
                                            <option value="{$category}">{$category}</option>
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
                                <h1 class="page-title">
                                    Description
                                </h1>

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
                                <h1 class="page-title">
                                    Tags - use comma (,) as a separator (max size: 10 characters)
                                </h1>

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
                            <td align="center" colspan="1" class="qa-form-tall-buttons">
                                <input value="Edit Question" title="" type="submit" class="btn">
                            </td>
                        </tr>
                        </tbody>
                    </table>

                </form>
            </div>
        </div>
    </div>
</div>

