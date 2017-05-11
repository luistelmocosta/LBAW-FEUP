<blockquote class="vote-up-down text-right">
    <div class="vote answer" data-id="{$answer['answerid']}" data-url="{url('controller/api/votes/vote')}">
        <div class="increment up{if $answer['voted'] == 1} active{/if}"></div>
        <div class="increment down{if $answer['voted'] == -1} active{/if}"></div>

        <div class="count vote-count value" data-url="{url('controller/api/votes/refresh_votes')}">
            {$answer['upvotes']}
        </div>
    </div>
</blockquote>