<title>Top Scored Users</title>
<div id="site-body" class="container">
    <div class="clearfix qa-main">

        <h1 class="page-title">
            Top scored users
        </h1>
        <div class="qa-part-ranking">
            <div class="page-users-list clearfix">
                {foreach $top_scored_users as $user}
                    <div class="user-card">
                        <div class="user-card-inner">
                            <div class="card-container">

                                <div class="f1_card">
                                    <div class="front face">
                                        <img class="avatar" height="150" width="150" src="{$user['photo']}">
                                    </div>
                                    <div class="back face center">
                                        <span class="activity q"><i>{$user['count_questions']}</i>Questions </span>
                                        <span class="activity a"><i>{$user['count_answers']}</i>Answers </span>
                                        <span class="activity c"><i>{$user['count_comments']}</i>Comments </span>
                                    </div>
                                </div>

                            </div>
                            <div class="card-bottom">
                                <a class="user-name" href="./user/admin">{$user['username']}</a>
                                <span class="score">{$user['count_votes_rating_received']} points </span>
                            </div>
                        </div>
                    </div>
                {/foreach}
            </div>
        </div>
    </div>

</div>
