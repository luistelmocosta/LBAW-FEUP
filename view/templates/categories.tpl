<div id="site-body" class="container">
    <div class="clearfix qa-main">
        <div class="col-sm-8 list-c">
            <h1 class="page-title">
                Categories
            </h1>
            <div class="qa-part-ranking">
                <div class="row qa-top-tags">
                    <div class="col-lg-4">
                        <ul>

                            <div class="list-group-item" style = "margin-bottom:15px;">

                                <div class = "col-sm-3 categories-col">
                                    {foreach old('categories', $categories) as $category }
                                        <li class="list-group-item"><a href="#">{$category['name']}</a>
                                            <span class="qa-tag-link">{$category['total']}</span></li>
                                    {/foreach}
                                </div>

                                <div class = "clearfix"></div>
                            </div>

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
                                    </ul></div>
                                <div class="acti-indicators">
                                    <ul>
                                        <li><i class="fa fa-circle text-info" style="color:#233445"></i> Questions <span>41</span></li>
                                        <li><i class="fa fa-circle text-info" style="color:#3fcf7f"></i> Answers <span>242</span></li>
                                        <li><i class="fa fa-circle text-info" style="color:#FF5F5F"></i> Comments <span>14</span></li>
                                        <li><i class="fa fa-circle text-info" style="color:#13C4A5"></i> Unanswered <span>9</span></li>
                                        <li><i class="fa fa-circle text-info" style="color:#F4C414"></i> Unselected <span>39</span></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="widget cs_tags">
                        <h3 class="widget-title">Tags
                            <a href="../view/categories.php">View all</a></h3>
                        <div class="ra-tags-widget clearfix">
                            <a href="" class="widget-tag">cleanstrap<span>23</span></a>
                            <a href="" class="widget-tag">cleanstrap theme<span>14</span></a>
                            <a href="" class="widget-tag">question2answer theme<span>10</span></a>
                            <a href="" class="widget-tag">q2a theme<span>9</span></a>
                            <a href="" class="widget-tag">cleanstrap options<span>5</span></a>
                            <a href="" class="widget-tag">cleanstrap widgets<span>4</span></a>
                            <a href="" class="widget-tag">development<span>3</span></a>
                            <a href="" class="widget-tag">widgets<span>3</span></a>
                            <a href="" class="widget-tag">install<span>2</span></a>
                            <a href="" class="widget-tag">votes<span>2</span></a>
                        </div>
                    </div>
                </div>
            </div>

        </div>