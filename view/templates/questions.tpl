<title>Questions</title>
<div id="site-body" class="container">
    <div class="clearfix qa-main">
        <div class="home-left-inner">

            <div class="col-md-8"">
            <h1 class="page-title">
                All questions
            </h1>
            <br>
            <div id="tabs">
                <ul>
                    <li><a href="#tabs-1">Recent Questions</a></li>
                    <li><a href="#tabs-2">Unanswered Questions</a></li>
                    <li><a href="#tabs-3">Top Scored Questions</a></li>
                </ul>
                <div id="tabs-1">
                    {include file="recent_questions.tpl"}

                </div>
                <div id="tabs-2">
                    {include file="unanswered_questions.tpl"}
                </div>
                <div id="tabs-3">
                    {include file="top_scored_questions.tpl"}
                </div>


                <ul class="pagination clearfix">
                    <li class="qa-page-links-item">
                        <span class="qa-page-selected">1</span>
                    </li>
                    <li class="qa-page-links-item">
                        <a href="./questions?start=20" class="qa-page-link">2</a>
                    </li>
                    <li class="qa-page-links-item">
                        <a href="./questions?start=40" class="qa-page-link">3</a>
                    </li>
                    <li class="qa-page-links-item">
                        <a href="./questions?start=20" class="qa-page-next">next »</a>
                    </li>
                </ul>

            </div>

        </div>
    </div>

</div>