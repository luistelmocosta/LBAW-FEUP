<title>{$user['username']}'s Profile</title>
{include file="common/messages.tpl"}
{include file="common/profile_common.tpl"}

<div class="panel panel-default">
    {if $permission == "admin" || $permission == "mod"}
        <div class="user-qac-list">
            <div id="user-content-position">
                <div class="widget cs_user_posts">
                    <h3 style="padding-left: 10px" class="widget-title user-post-title">{$user['username']}'s Bans Registers</h3>
                    <div class="ra-ua-widget">
                        {foreach $user_mod_regs_bans as $mod_reg}
                            {include file="user_profile_mod_regs.tpl"}
                        {/foreach}
                    </div>
                    <h3 style="padding-left: 10px" class="widget-title user-post-title">{$user['username']}'s Warnings Registers</h3>
                    <div class="ra-ua-widget">
                        {foreach $user_mod_regs_warns as $mod_reg}
                            {include file="user_profile_mod_regs.tpl"}
                        {/foreach}
                    </div>
                </div>
            </div>
        </div>
    {/if}
</div>

<div class="panel panel-default">
    <div class="user-qac-list">
        <div id="user-content-position">
            <div class="widget cs_user_posts">
                <h3 style="padding-left: 10px" class="widget-title user-post-title">{$user['username']}'s Questions</h3>
                <div class="ra-ua-widget">
                    {foreach $user_questions as $question}
                        {include file="user_profile_questions.tpl"}
                    {/foreach}
                </div>
            </div>
        </div>
    </div>
</div>
</div>