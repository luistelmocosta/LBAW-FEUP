<li class="top-user clearfix">
    <div class="avatar" data-id="1" data-handle="admin">
        <a href="{profileUrl($user['userid'])}" class="qa-avatar-link">
            <img src="{$user['avatar']}" width="30"
                 height="30" class="qa-avatar-image"></a>
    </div>
    <div class="top-user-data">
        <span class="points">{$user['count_votes_rating_received']} points</span>
        <a href={profileUrl($user['userid'])} class="name">{$user['username']}</a>
        <p class="counts">
            <span>{$user['count_questions']} questions</span>
            <span>{$user['count_answers']} answers</span>
            <span>{$user['count_comments']} comments</span>
        </p>
    </div>
</li>