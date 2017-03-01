{include file='../common/header.tpl'}

<div id="ajax-item">
    <div id="site-body" class="container">
        <div class="clearfix qa-main">
            <div class="col-sm-12 list-c">
                <h1 class="page-title">
                    Ask a question
                </h1>
                <div class="qa-part-form">
                    <form name="ask" method="post" action="./ask">
                        <table class="qa-form-tall-table">
                            <tbody><tr>
                                <td class="qa-form-tall-label">
                                    The question in one sentence:
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-data">
                                    <input name="title" id="title" autocomplete="off" onchange="qa_title_change(this.value);" type="text" value="" class="qa-form-tall-text">
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-data">
                                    <span id="similar"></span>
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-label">
                                    Category:
                                    &nbsp;
                                    <select name="category_0" id="category_0" onchange="qa_category_select('category');" class="qa-form-tall-select" style="display: none;">
                                        <option value=""></option>
                                    </select><span id="category_0_sub"> <select name="category_1" id="category_1" onchange="qa_category_select('category');" class="qa-form-tall-select"><option value="" selected=""></option><option value="1">CleanStrap</option><option value="2">Widgets</option><option value="3">Q2A platform</option></select></span>
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-data">
                                    <div class="qa-form-tall-note"><div id="category_note"></div></div>
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-label">
                                    More information for the question:
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-data">
                                    <textarea name="content" rows="12" cols="40" class="qa-form-tall-text"
                                              style="visibility: hidden; display: none;">

                                    </textarea>
                                    <div id="cke_content" class="cke_1 cke cke_reset cke_chrome cke_editor_content cke_ltr cke_browser_webkit"
                                         dir="ltr" lang="en" role="application" aria-labelledby="cke_content_arialbl">
                                        <span id="cke_content_arialbl" class="cke_voice_label">Rich Text Editor, content</span>
                                        <div class="cke_inner cke_reset" role="presentation">
                                            <span id="cke_1_top"
                                                                                                   class="cke_top cke_reset_all"
                                                                                                   role="presentation"
                                                                                                   style="height: auto; user-select: none;">
                                                <span id="cke_8" class="cke_voice_label">Editor toolbars
                                                </span>
                                                <span id="cke_1_toolbox" class="cke_toolbox" role="group" aria-labelledby="cke_8"
                                                      onmousedown="return false;">
                                                    <span id="cke_11" class="cke_toolbar" role="toolbar">
                                                        <span class="cke_toolbar_start"
                                                        </span>

                                                        <span class="cke_toolgroup" role="presentation">
                                                            <a id="cke_12" class="cke_button cke_button__bold  cke_button_off"
                                                               href="javascript:void('Bold')" title="Bold" tabindex="-1" hidefocus="true"
                                                               role="button" aria-labelledby="cke_12_label"
                                                               aria-haspopup="false"
                                                               onkeydown="return CKEDITOR.tools.callFunction(1,event);"
                                                               onfocus="return CKEDITOR.tools.callFunction(2,event);"
                                                               onclick="CKEDITOR.tools.callFunction(3,this);return false;">
                                                                <span class="cke_button_icon cke_button__bold_icon"
                                                                      style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);
                                                                      background-position:0 -24px;
                                                                      background-size:auto;">&nbsp;
                                                                </span>
                                                                <span id="cke_12_label" class="cke_button_label cke_button__bold_label" aria-hidden="false">Bold
                                                                </span>
                                                            </a>
                                                            <a id="cke_13" class="cke_button cke_button__italic  cke_button_off" href="javascript:void('Italic')" title="Italic" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_13_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(4,event);" onfocus="return CKEDITOR.tools.callFunction(5,event);" onclick="CKEDITOR.tools.callFunction(6,this);return false;">
                                                                <span class="cke_button_icon cke_button__italic_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -48px;background-size:auto;">&nbsp;</span>
                                                                <span id="cke_13_label" class="cke_button_label cke_button__italic_label" aria-hidden="false">Italic</span>
                                                            </a>
                                                            <a id="cke_14" class="cke_button cke_button__underline  cke_button_off" href="javascript:void('Underline')" title="Underline" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_14_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(7,event);" onfocus="return CKEDITOR.tools.callFunction(8,event);" onclick="CKEDITOR.tools.callFunction(9,this);return false;">
                                                                <span class="cke_button_icon cke_button__underline_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -144px;background-size:auto;">&nbsp;</span>
                                                                <span id="cke_14_label" class="cke_button_label cke_button__underline_label" aria-hidden="false">Underline</span></a><a id="cke_15" class="cke_button cke_button__strike  cke_button_off" href="javascript:void('Strike Through')" title="Strike Through" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_15_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(10,event);" onfocus="return CKEDITOR.tools.callFunction(11,event);" onclick="CKEDITOR.tools.callFunction(12,this);return false;">
                                                                <span class="cke_button_icon cke_button__strike_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -72px;background-size:auto;">&nbsp;</span>
                                                                <span id="cke_15_label" class="cke_button_label cke_button__strike_label" aria-hidden="false">Strike Through</span></a></span>
                                                    <span class="cke_toolbar_end"></span></span>
                                                <span id="cke_16" class="cke_toolbar" role="toolbar">
                                                    <span class="cke_toolbar_start"></span>
                                                    <span id="cke_9" class="cke_combo cke_combo__font  cke_combo_off" role="presentation">
                                                        <span id="cke_9_label" class="cke_combo_label">Font</span>
                                                        <a class="cke_combo_button" title="Font Name" tabindex="-1" href="javascript:void('Font Name')" hidefocus="true" role="button" aria-labelledby="cke_9_label" aria-haspopup="true" onkeydown="return CKEDITOR.tools.callFunction(14,event,this);" onfocus="return CKEDITOR.tools.callFunction(15,event);" onclick="CKEDITOR.tools.callFunction(13,this);return false;">
                                                            <span id="cke_9_text" class="cke_combo_text cke_combo_inlinelabel">Font</span>
                                                            <span class="cke_combo_open"><span class="cke_combo_arrow"></span></span></a></span>
                                                    <span id="cke_10" class="cke_combo cke_combo__fontsize  cke_combo_off" role="presentation"><span id="cke_10_label" class="cke_combo_label">Size</span><a class="cke_combo_button" title="Font Size" tabindex="-1" href="javascript:void('Font Size')" hidefocus="true" role="button" aria-labelledby="cke_10_label" aria-haspopup="true" onkeydown="return CKEDITOR.tools.callFunction(17,event,this);" onfocus="return CKEDITOR.tools.callFunction(18,event);" onclick="CKEDITOR.tools.callFunction(16,this);return false;">
                                                            <span id="cke_10_text" class="cke_combo_text cke_combo_inlinelabel">Size</span>
                                                            <span class="cke_combo_open"><span class="cke_combo_arrow"></span>
                                                            </span>
                                                        </a>
                                                    </span>
                                                    <span class="cke_toolbar_end">

                                                    </span>
                                                </span>
                                                <span id="cke_17" class="cke_toolbar" role="toolbar"><span class="cke_toolbar_start">

                                                    </span>
                                                    <span class="cke_toolgroup" role="presentation">
                                                        <a id="cke_18" class="cke_button cke_button__textcolor cke_button_off " href="javascript:void('Text Color')" title="Text Color" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_18_label" aria-haspopup="true" onkeydown="return CKEDITOR.tools.callFunction(19,event);" onfocus="return CKEDITOR.tools.callFunction(20,event);" onclick="CKEDITOR.tools.callFunction(21,this);return false;">
                                                            <span class="cke_button_icon cke_button__textcolor_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -408px;background-size:auto;">&nbsp;</span><span id="cke_18_label" class="cke_button_label cke_button__textcolor_label" aria-hidden="false">Text Color</span>
                                                            <span class="cke_button_arrow"></span>
                                                        </a>
                                                        <a id="cke_19" class="cke_button cke_button__bgcolor cke_button_off " href="javascript:void('Background Color')" title="Background Color" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_19_label" aria-haspopup="true" onkeydown="return CKEDITOR.tools.callFunction(22,event);" onfocus="return CKEDITOR.tools.callFunction(23,event);" onclick="CKEDITOR.tools.callFunction(24,this);return false;">
                                                            <span class="cke_button_icon cke_button__bgcolor_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -384px;background-size:auto;">&nbsp;</span>
                                                            <span id="cke_19_label" class="cke_button_label cke_button__bgcolor_label" aria-hidden="false">Background Color</span>
                                                            <span class="cke_button_arrow"></span></a></span><span class="cke_toolbar_end">

                                                    </span>
                                                </span>
                                                <span id="cke_20" class="cke_toolbar" role="toolbar">
                                                    <span class="cke_toolbar_start"></span>
                                                    <span class="cke_toolgroup" role="presentation"><a id="cke_21" class="cke_button cke_button__link  cke_button_off" href="javascript:void('Link')" title="Link" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_21_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(25,event);" onfocus="return CKEDITOR.tools.callFunction(26,event);" onclick="CKEDITOR.tools.callFunction(27,this);return false;">
                                                            <span class="cke_button_icon cke_button__link_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -1248px;background-size:auto;">&nbsp;
                                                            </span>
                                                            <span id="cke_21_label" class="cke_button_label cke_button__link_label" aria-hidden="false">Link</span>
                                                        </a>
                                                        <a id="cke_22" class="cke_button cke_button__unlink cke_button_disabled " href="javascript:void('Unlink')" title="Unlink" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_22_label" aria-haspopup="false" aria-disabled="true" onkeydown="return CKEDITOR.tools.callFunction(28,event);" onfocus="return CKEDITOR.tools.callFunction(29,event);" onclick="CKEDITOR.tools.callFunction(30,this);return false;">
                                                            <span class="cke_button_icon cke_button__unlink_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -1272px;background-size:auto;">&nbsp;
                                                            </span><span id="cke_22_label" class="cke_button_label cke_button__unlink_label" aria-hidden="false">Unlink
                                                            </span>
                                                        </a>
                                                    </span>
                                                    <span class="cke_toolbar_end"></span></span><span id="cke_23" class="cke_toolbar" role="toolbar">
                                                    <span class="cke_toolbar_start">

                                                    </span>
                                                    <span class="cke_toolgroup" role="presentation"><a id="cke_24" class="cke_button cke_button__justifyleft  cke_button_off" href="javascript:void('Align Left')" title="Align Left" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_24_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(31,event);" onfocus="return CKEDITOR.tools.callFunction(32,event);" onclick="CKEDITOR.tools.callFunction(33,this);return false;"><span class="cke_button_icon cke_button__justifyleft_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -1128px;background-size:auto;">&nbsp;
                                                            </span>
                                                            <span id="cke_24_label" class="cke_button_label cke_button__justifyleft_label" aria-hidden="false">Align Left
                                                            </span>
                                                        </a>
                                                        <a id="cke_25" class="cke_button cke_button__justifycenter  cke_button_off" href="javascript:void('Center')" title="Center" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_25_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(34,event);" onfocus="return CKEDITOR.tools.callFunction(35,event);" onclick="CKEDITOR.tools.callFunction(36,this);return false;">
                                                            <span class="cke_button_icon cke_button__justifycenter_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -1104px;background-size:auto;">&nbsp;</span>
                                                            <span id="cke_25_label" class="cke_button_label cke_button__justifycenter_label" aria-hidden="false">Center</span>
                                                        </a><a id="cke_26" class="cke_button cke_button__justifyright  cke_button_off" href="javascript:void('Align Right')" title="Align Right" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_26_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(37,event);" onfocus="return CKEDITOR.tools.callFunction(38,event);" onclick="CKEDITOR.tools.callFunction(39,this);return false;">
                                                            <span class="cke_button_icon cke_button__justifyright_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -1152px;background-size:auto;">&nbsp;</span>
                                                            <span id="cke_26_label" class="cke_button_label cke_button__justifyright_label" aria-hidden="false">Align Right</span></a><a id="cke_27" class="cke_button cke_button__justifyblock  cke_button_off" href="javascript:void('Justify')" title="Justify" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_27_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(40,event);" onfocus="return CKEDITOR.tools.callFunction(41,event);" onclick="CKEDITOR.tools.callFunction(42,this);return false;">
                                                            <span class="cke_button_icon cke_button__justifyblock_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -1080px;background-size:auto;">&nbsp;</span><span id="cke_27_label" class="cke_button_label cke_button__justifyblock_label" aria-hidden="false">Justify
                                                            </span>
                                                        </a>
                                                    </span>
                                                    <span class="cke_toolbar_end">

                                                    </span>
                                                </span>
                                                <span id="cke_28" class="cke_toolbar" role="toolbar">
                                                    <span class="cke_toolbar_start"></span>
                                                    <span class="cke_toolgroup" role="presentation">
                                                        <a id="cke_29" class="cke_button cke_button__numberedlist  cke_button_off" href="javascript:void('Insert/Remove Numbered List')" title="Insert/Remove Numbered List" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_29_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(43,event);" onfocus="return CKEDITOR.tools.callFunction(44,event);" onclick="CKEDITOR.tools.callFunction(45,this);return false;">
                                                            <span class="cke_button_icon cke_button__numberedlist_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -1368px;background-size:auto;">&nbsp;
                                                            </span>
                                                            <span id="cke_29_label" class="cke_button_label cke_button__numberedlist_label" aria-hidden="false">Insert/Remove Numbered List
                                                            </span>
                                                        </a>
                                                        <a id="cke_30" class="cke_button cke_button__bulletedlist  cke_button_off" href="javascript:void('Insert/Remove Bulleted List')" title="Insert/Remove Bulleted List" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_30_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(46,event);" onfocus="return CKEDITOR.tools.callFunction(47,event);" onclick="CKEDITOR.tools.callFunction(48,this);return false;">
                                                            <span class="cke_button_icon cke_button__bulletedlist_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -1320px;background-size:auto;">&nbsp;
                                                            </span>
                                                            <span id="cke_30_label" class="cke_button_label cke_button__bulletedlist_label" aria-hidden="false">Insert/Remove Bulleted List</span>
                                                        </a>
                                                        <span class="cke_toolbar_separator" role="separator">

                                                        </span>
                                                        <a id="cke_31" class="cke_button cke_button__outdent cke_button_disabled " href="javascript:void('Decrease Indent')" title="Decrease Indent" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_31_label" aria-haspopup="false" aria-disabled="true" onkeydown="return CKEDITOR.tools.callFunction(49,event);" onfocus="return CKEDITOR.tools.callFunction(50,event);" onclick="CKEDITOR.tools.callFunction(51,this);return false;">
                                                            <span class="cke_button_icon cke_button__outdent_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -1032px;background-size:auto;">&nbsp;
                                                            </span>
                                                            <span id="cke_31_label" class="cke_button_label cke_button__outdent_label" aria-hidden="false">Decrease Indent
                                                            </span>
                                                        </a>
                                                        <a id="cke_32" class="cke_button cke_button__indent  cke_button_off" href="javascript:void('Increase Indent')" title="Increase Indent" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_32_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(52,event);" onfocus="return CKEDITOR.tools.callFunction(53,event);" onclick="CKEDITOR.tools.callFunction(54,this);return false;">
                                                            <span class="cke_button_icon cke_button__indent_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -984px;background-size:auto;">&nbsp;</span>
                                                            <span id="cke_32_label" class="cke_button_label cke_button__indent_label" aria-hidden="false">Increase Indent</span>
                                                        </a><a id="cke_33" class="cke_button cke_button__blockquote  cke_button_off" href="javascript:void('Block Quote')" title="Block Quote" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_33_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(55,event);" onfocus="return CKEDITOR.tools.callFunction(56,event);" onclick="CKEDITOR.tools.callFunction(57,this);return false;">
                                                            <span class="cke_button_icon cke_button__blockquote_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -216px;background-size:auto;">&nbsp;</span>
                                                            <span id="cke_33_label" class="cke_button_label cke_button__blockquote_label" aria-hidden="false">Block Quote</span>
                                                        </a>
                                                    </span>
                                                    <span class="cke_toolbar_end">

                                                    </span>
                                                </span>
                                                <span id="cke_34" class="cke_toolbar" role="toolbar">
                                                    <span class="cke_toolbar_start">

                                                    </span>
                                                    <span class="cke_toolgroup" role="presentation">
                                                        <a id="cke_35" class="cke_button cke_button__image  cke_button_off" href="javascript:void('Image')" title="Image" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_35_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(58,event);" onfocus="return CKEDITOR.tools.callFunction(59,event);" onclick="CKEDITOR.tools.callFunction(60,this);return false;">
                                                            <span class="cke_button_icon cke_button__image_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -936px;background-size:auto;">&nbsp;
                                                            </span>
                                                            <span id="cke_35_label" class="cke_button_label cke_button__image_label" aria-hidden="false">Image
                                                            </span>
                                                        </a>
                                                        <a id="cke_36" class="cke_button cke_button__flash  cke_button_off" href="javascript:void('Flash')" title="Flash" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_36_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(61,event);" onfocus="return CKEDITOR.tools.callFunction(62,event);" onclick="CKEDITOR.tools.callFunction(63,this);return false;"><span class="cke_button_icon cke_button__flash_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -576px;background-size:auto;">&nbsp;</span>
                                                            <span id="cke_36_label" class="cke_button_label cke_button__flash_label" aria-hidden="false">Flash
                                                            </span>
                                                        </a>
                                                        <a id="cke_37" class="cke_button cke_button__table  cke_button_off" href="javascript:void('Table')" title="Table" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_37_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(64,event);" onfocus="return CKEDITOR.tools.callFunction(65,event);" onclick="CKEDITOR.tools.callFunction(66,this);return false;"><span class="cke_button_icon cke_button__table_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -1896px;background-size:auto;">&nbsp;
                                                            </span>
                                                            <span id="cke_37_label" class="cke_button_label cke_button__table_label" aria-hidden="false">Table
                                                            </span>
                                                        </a>
                                                        <a id="cke_38" class="cke_button cke_button__horizontalrule  cke_button_off" href="javascript:void('Insert Horizontal Line')" title="Insert Horizontal Line" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_38_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(67,event);" onfocus="return CKEDITOR.tools.callFunction(68,event);" onclick="CKEDITOR.tools.callFunction(69,this);return false;">
                                                            <span class="cke_button_icon cke_button__horizontalrule_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -888px;background-size:auto;">&nbsp;</span>
                                                            <span id="cke_38_label" class="cke_button_label cke_button__horizontalrule_label" aria-hidden="false">Insert Horizontal Line
                                                            </span>
                                                        </a>
                                                        <a id="cke_39" class="cke_button cke_button__smiley  cke_button_off" href="javascript:void('Smiley')" title="Smiley" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_39_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(70,event);" onfocus="return CKEDITOR.tools.callFunction(71,event);" onclick="CKEDITOR.tools.callFunction(72,this);return false;">
                                                            <span class="cke_button_icon cke_button__smiley_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -1056px;background-size:auto;">&nbsp;
                                                            </span>
                                                            <span id="cke_39_label" class="cke_button_label cke_button__smiley_label" aria-hidden="false">Smiley
                                                            </span>
                                                        </a>
                                                        <a id="cke_40" class="cke_button cke_button__specialchar  cke_button_off" href="javascript:void('Insert Special Character')" title="Insert Special Character" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_40_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(73,event);" onfocus="return CKEDITOR.tools.callFunction(74,event);" onclick="CKEDITOR.tools.callFunction(75,this);return false;">
                                                            <span class="cke_button_icon cke_button__specialchar_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -1848px;background-size:auto;">&nbsp;
                                                            </span>
                                                            <span id="cke_40_label" class="cke_button_label cke_button__specialchar_label" aria-hidden="false">Insert Special Character</span></a></span><span class="cke_toolbar_end"></span></span><span id="cke_41" class="cke_toolbar" role="toolbar">
                                                    <span class="cke_toolbar_start">

                                                    </span>
                                                    <span class="cke_toolgroup" role="presentation">
                                                        <a id="cke_42" class="cke_button cke_button__removeformat  cke_button_off" href="javascript:void('Remove Format')" title="Remove Format" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_42_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(76,event);" onfocus="return CKEDITOR.tools.callFunction(77,event);" onclick="CKEDITOR.tools.callFunction(78,this);return false;">
                                                            <span class="cke_button_icon cke_button__removeformat_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -1680px;background-size:auto;">&nbsp;
                                                            </span>
                                                            <span id="cke_42_label" class="cke_button_label cke_button__removeformat_label" aria-hidden="false">Remove Format
                                                            </span>
                                                        </a>
                                                        <a id="cke_43" class="cke_button cke_button__maximize  cke_button_off" href="javascript:void('Maximize')" title="Maximize" tabindex="-1" hidefocus="true" role="button" aria-labelledby="cke_43_label" aria-haspopup="false" onkeydown="return CKEDITOR.tools.callFunction(79,event);" onfocus="return CKEDITOR.tools.callFunction(80,event);" onclick="CKEDITOR.tools.callFunction(81,this);return false;">
                                                            <span class="cke_button_icon cke_button__maximize_icon" style="background-image:url(http://demo.qa-themes.com/cleanstrap/qa-plugin/ckeditor4/plugins/icons.png?t=E8PB);background-position:0 -1392px;background-size:auto;">&nbsp;
                                                            </span>
                                                            <span id="cke_43_label" class="cke_button_label cke_button__maximize_label" aria-hidden="false">Maximize
                                                            </span>
                                                        </a>
                                                    </span>
                                                    <span class="cke_toolbar_end">

                                                    </span>
                                                </span>
                                            </span>
                                            </span>
                                            <div id="cke_1_contents" class="cke_contents cke_reset" role="presentation" style="height: 200px;">
                                                <span id="cke_47" class="cke_voice_label">Press ALT 0 for help
                                                </span>
                                                <iframe src="" frameborder="0" class="cke_wysiwyg_frame cke_reset" title="Rich Text Editor, content" aria-describedby="cke_47" tabindex="0" allowtransparency="true" style="width: 719px; height: 100%;">

                                                </iframe>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-label">
                                    Tags - use comma (,) as a separator:
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-data">
                                    <input name="tags" id="tags" autocomplete="off" onkeyup="qa_tag_hints();" onmouseup="qa_tag_hints();" type="text" value="" class="qa-form-tall-text">
                                    <div class="qa-form-tall-note"><span id="tag_examples_title" style="display:none;">Example tags: </span><span id="tag_complete_title" style="display:none;">Matching tags: </span><span id="tag_hints"></span></div>
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-label">
                                    Your name to display (optional):
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-data">
                                    <input name="name" type="text" value="" class="qa-form-tall-text">
                                </td>
                            </tr>
                            <tr>
                                <td class="qa-form-tall-label">
                                    <label>
                                        <input name="notify" id="notify" onclick="if (document.getElementById('notify').checked) document.getElementById('email').focus();" type="checkbox" value="1" checked="" class="qa-form-tall-checkbox">
                                        <span id="email_shown">Email me at this address if my question is answered or commented on:</span><span id="email_hidden" style="display:none;">Email me if my question is answered or commented on</span>
                                    </label>
                                </td>
                            </tr>
                            </tbody><tbody id="email_display">
                            <tr>
                                <td class="qa-form-tall-data">
                                    <input name="email" id="email" type="text" value="" class="qa-form-tall-text">
                                    <div class="qa-form-tall-note">Privacy: Your email address will only be used for sending these notifications.</div>
                                </td>
                            </tr>
                            </tbody>
                            <tbody><tr>
                                <td colspan="1" class="qa-form-tall-buttons">
                                    <input onclick="qa_show_waiting_after(this, false); qa_ckeditor4_content.updateElement();" value="Ask the Question" title="" type="submit" class="qa-form-tall-button qa-form-tall-button-ask">
                                </td>
                            </tr>
                            </tbody></table>
                        <input type="hidden" name="editor" value="CKEditor4">
                        <input type="hidden" name="code" value="0-1488408582-78c8845912750e5b03d04095dfd67aca994b7898">
                        <input type="hidden" name="doask" value="1">
                    </form>
                </div>
            </div>
        </div>

        {include file='../common/footer.tpl'}

    </div>
</div>