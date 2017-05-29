<div id="site-body" class="container">
    <div class="clearfix qa-main">

        <h1 align="center">Categories</h1>
        <br class="clearfix">
            <div class="qa-part-ranking">
                <div class="row qa-top-tags">
                    {foreach array_chunk($categories, 3) as $chunk_categories}
                        <div class="col-lg-4">
                            <ul>
                                <div class="list-group-item" style = "margin-bottom:15px;">
                                    {foreach $chunk_categories as $category }
                                        <li class="list-group-item"><a href="{categoryQuestionsUrl($category['categoryid'])}">{$category['name']}</a>
                                            <span class="qa-tag-link">{$category['total']}</span></li>
                                    {/foreach}
                                </div>
                            </ul>
                        </div>
                    {/foreach}
                </div>
            </div>

        <div class="col-sm-4 side-c">

        </div>
