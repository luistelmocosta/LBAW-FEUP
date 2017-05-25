<div class="question-summary narrow">

    <div class="col-md-12">

        <div class="summary">
            <h3 style="font-size: 15px; line-height: 1.4; margin-bottom: .5em;">
                {$mod_reg['reason']}
            </h3>
        </div>

        {if $mod_reg['end_date'] != null}
            <div class="stat" style = "float: right">
                <div class="votes">
                    <span title="end_date">
                        {$mod_reg['end_date']}
                    </span>
                    <div>End Date</div>
                </div>
            </div>
        {/if}

        <div class = "statistics col-sm-12 text-right" style="float: right">
        <span>
            <i class = "glyphicon glyphicon-time"></i>
            <span class="question-updated-at"></span>{$mod_reg['date_creation']}
        </div>

    </div>

</div>