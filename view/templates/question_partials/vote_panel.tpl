<blockquote class="vote-up-down text-right">
    <div class="vote chev" data-id="{$question['publicationid']}" data-url="{url('controller/api/votes/vote')}">
        <div class="increment up{if $question['voted'] == 1} active{/if}"></div>
        <div class="increment down{if $question['voted'] == -1} active{/if}"></div>

        <div class="count vote-count value" data-url="{url('api/votes/refresh_votes')}">
            {$question['upvotes']}
        </div>
    </div>
</blockquote>