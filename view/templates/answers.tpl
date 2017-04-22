<div class="qa-a-item-main">
    <div class="asker-detail clearfix">

        <div class="user-info no-overflow">
            <h3 class="asker-name"></h3>
            <p class="asker-point"> <span class="title"></span></p>
        </div>
        <div class="enabled voting clearfix voting-vertical qa-voting-net" id="voting_187">
            <a title="" class=" fa fa-thumbs-up enabled vote-up enabled" data-original-title="Click to vote up"></a>
            <span class="count">0</span>
            <a title="" class=" fa fa-thumbs-down enabled vote-down enabled" data-original-title="Click to vote down"></a>
        </div>
    </div>
    <div class="a-item-inner-wrap">
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
                <button class="btn icon-chat" title="Add a comment on this answer" type="button" id="showarea" name="showarea" value="Show Textarea">Comment</button>
                <div id="textarea">
                    <form method="post" action="{$BASE_URL}controller/actions/comments/create_comment.php">
                        <textarea id="" name="comment" rows="4" cols="40" class="qa-form-tall-text"></textarea>
                        <input value="Add comment" title="" type="submit" class="qa-form-tall-button qa-form-tall-button-comment">
                        <input type="hidden" name = "answerid" value="{$answer['answerid']}">
                        <input value="Cancel" id="cancel" title="" type="button" class="qa-form-tall-button qa-form-tall-button-comment">
                        <button id="textarea-ok" name="ok" type="button" value="Ok">
                    </form>
                </div>

                <script type="text/javascript">
                    $("#textarea, #textarea-ok").hide(); // or you can have hidden w/ CSS
                    $("#showarea").click(function(){
                        $("#textarea").show();
                    });
                    $("#textarea-ok, #cancel").click(function(){
                        $("#textarea").hide();
                    });
                </script>
            </div>
        </div>

        <div class="qa-a-item-c-list" style="display:none;" id="">
            <div class="qa-c-list-item  hentry comment" id="c3574" style="overflow: hidden;">
                <div class="asker-avatar">
                    <a href="../user/lbaw1641"><img src="http://www.gravatar.com/avatar/8b21c0ba9bf921fa9aecfbfa62e26e08?s=30"></a>
                </div>
                <div class="qa-c-wrap">
                        <span class="qa-c-item-meta">
			<a href="../3557/how-to-upload-featured-image-while-adding-new-post?show=3574#c3574" class="qa-c-item-what">commented</a>
			<span class="qa-c-item-when">
				<span class="qa-c-item-when-data"><span class="published"><span class="value-title" title="2017-04-21T00:27:53+0000"></span>1 second</span></span><span class="qa-c-item-when-pad"> ago</span>
			</span>
			<span class="qa-c-item-who">
				<span class="qa-c-item-who-pad">by </span>
				<span class="qa-c-item-who-data"><span class="vcard author"><a href="../user/lbaw1641" class="qa-user-link url nickname">lbaw1641</a></span></span>
				<span class="qa-c-item-who-points">
					<span class="qa-c-item-who-points-pad">(</span><span class="qa-c-item-who-points-data">140</span><span class="qa-c-item-who-points-pad"> points)</span>
				</span>
			</span>
		</span>
                    <div class="qa-c-item-content">
                        <a name="3574"></a><div class="entry-content">just a test jaskdlsçadasd</div>
                    </div>
                </div>
            </div>
        </div> <!-- END qa-c-list -->

        <input name="code" value="0-1489600293-0c8505c3a885e0a52578dc109fb02255a05018b6" type="hidden">
        <input name="qa_click" value="" type="hidden">

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