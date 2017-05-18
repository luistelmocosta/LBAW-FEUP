<title>Top Scored Users</title>
<div id="site-body" class="container">
    <div class="clearfix qa-main">
        <div class="col-sm-8 list-c">
            <h1 class="page-title">
                Top scoring users
            </h1>
            <div class="qa-part-ranking">
                <div class="page-users-list clearfix">
                    {foreach array_chunk($categories, 4) as $chunk_categories}
                    {foreach  $chunk_categories as $category }
                    <div class = "col-sm-3 categories-col">
                        <li class="list-group-item"><a href="#">{$category['name']}</a>
                            <span class="qa-tag-link">{$category['total']}</span></li>
                        {/foreach}
                    </div>
{/foreach}
                </div>
            </div>
        </div>
    </div>
</div>