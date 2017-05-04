<div id="site-body" class="container">
    <div class="clearfix qa-main">
        <div class="col-sm-8 list-c">
            <h1 class="page-title">
                Categories
            </h1>
            <div class="qa-part-ranking">
                <div class="row qa-top-tags">
                    <div class="col-lg-20">
                        <ul>
                            {foreach array_chunk($categories, 20) as $category}
                                <div class="list-group-item" style = "margin-bottom:15px;">
                                    {foreach old('categories', $categories) as $category }
                                        <div class = "col-sm-3 categories-col">
                                            <li class="list-group-item"><a href="{category_questions_url($category['categoryid'])}">{$category['name']}</a>
                                                <span class="qa-tag-link">{$category['total']}</span></li>
                                        </div>
                                    {/foreach}
                                    <div class = "clearfix"></div>
                                </div>
                            {/foreach}
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-4 side-c">
            <div class="qa-sidepanel">
                <div id="right-position">
                    <div class="widget cs_site_status">											<h3 class="widget-title">Site Status</h3>
                        <div class="ra-site-status-widget">
                            <div class="site-status-inner clearfix"><div class="bar-float"><div class="sparkline" data-type="bar" data-bar-color="#E45840" data-bar-width="30" data-height="80"><canvas width="158" height="80" style="display: inline-block; width: 158px; height: 80px; vertical-align: top;"></canvas></div>
                                    <ul class="list-inline text-muted axis">
                                        <li style="width: 30px; margin-right: 2px;">Que</li><li style="width: 30px; margin-right: 2px;">Ans</li><li style="width: 30px; margin-right: 2px;">Com</li><li style="width: 30px; margin-right: 2px;">UA</li><li style="width: 30px; margin-right: 2px;">US</li>
                                    </ul>
                                </div>
                                <div class="acti-indicators">
                                    <ul>
                                        <li><i class="fa fa-circle text-info" style="color:#233445"></i> Questions <span class="qa-tag-link">{$questions['total']}</span></li>
                                        <li><i class="fa fa-circle text-info" style="color:#3fcf7f"></i> Answers <span class="qa-tag-link">{$answers['total']}</span></li>
                                        <li><i class="fa fa-circle text-info" style="color:#FF5F5F"></i> Comments <span class="qa-tag-link">{$comments['total']}</span></li>
                                        <li><i class="fa fa-circle text-info" style="color:#13C4A5"></i> Unanswered <span class="qa-tag-link">{$unanswered['total']}</span></li>
                                        <li><i class="fa fa-circle text-info" style="color:#F4C414"></i> Unselected <span class="qa-tag-link">{$unselected['total']}</span></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="widget cs_tags">
                        <h3 class="widget-title">Tags</h3>
                        <div class="ra-tags-widget clearfix">
                                    {foreach $tags as $tag }
                                        <div class = "col-sm-4 categories-col">
                                            <li class="list-tag-tag-list"><a href="#">{$tag['name']}</a></li>
                                        </div>
                                    {/foreach}
                                    <div class = "clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>