
<div id="site-body" class="container">
    <div class="clearfix qa-main">
        <div class="col-sm-12 list-c">


            <h1>Edit your Question</h1>
            <br>
            <div class="qa-part-form-q-edit">
                <form method="post" action="">
                    <table class="qa-form-tall-table">
                        <tbody><tr>
                            <td class="qa-form-tall-label" style="padding-bottom: 20px">
                                Title
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-tall-data" style="padding-bottom: 20px">
                                <input name="q_title" type="text" value="Create class in php" class="qa-form-tall-text">
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-tall-label">
                                Category:
                                &nbsp;
                                <select name="q_category_0" id="q_category_0" onchange="qa_category_select('q_category');" class="qa-form-tall-select" style="display: none;">
                                    <option value="3" selected="">Sports</option>
                                </select><span id="q_category_0_sub"> <select name="q_category_1" id="q_category_1" onchange="qa_category_select('q_category');" class="qa-form-tall-select">
                                                        <option value="1">Technology</option><option value="2">Widgets</option>
                                                        <option value="3">Politics</option>
                                                    </select></span>
                            </td>
                        </tr>

                        <tr>
                            <td class="qa-form-tall-label" style="padding-bottom: 30px; padding-top: 20px">
                                <b>Edit question info:</b>
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-tall-data">
                                <textarea name="editor1"></textarea>
                                <script>
                                    CKEDITOR.replace( 'editor1' );
                                </script>

                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-tall-label">
                                Tags - use comma (,) as a separator:
                            </td>
                        </tr>
                        <tr>
                            <td class="qa-form-tall-data">
                                <input name="q_tags" id="tags" autocomplete="off" onkeyup="qa_tag_hints();" onmouseup="qa_tag_hints();" type="text" value="php" class="qa-form-tall-text">
                                <div class="qa-form-tall-note"><span id="tag_examples_title" style="display:none;">Example tags: </span><span id="tag_complete_title" style="display:none;">Matching tags: </span><span id="tag_hints"></span></div>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="1" class="qa-form-tall-buttons">
                                <input onclick="qa_show_waiting_after(this, false); qa_ckeditor4_q_content.updateElement();" value="Save Changes" title="" type="submit" class="qa-form-tall-button qa-form-tall-button-save">
                                <input name="docancel" value="Cancel" title="" type="submit" class="qa-form-tall-button qa-form-tall-button-cancel">
                            </td>
                        </tr>
                        </tbody></table>
                    <input type="hidden" name="q_dosave" value="1">
                    <input type="hidden" name="code" value="1-1488980392-c4f8b713d85c5c46c4e0c0c1964a0ea1aaa838a8">
                    <input type="hidden" name="q_editor" value="CKEditor4">
                </form>
            </div>
            <div class="qa-part-a-list">
                <div class="qa-a-list" id="a_list">

                </div> <!-- END qa-a-list -->

            </div>


        </div>
    </div>
</div>