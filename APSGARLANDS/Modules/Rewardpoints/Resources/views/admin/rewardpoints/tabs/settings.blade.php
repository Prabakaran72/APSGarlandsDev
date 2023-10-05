<div class="row">
    <div class="col-md-8">
    {{ Form::checkbox('enable_bday_points', trans('rewardpoints::attributes.enable_bday_points'), trans('rewardpoints::rewardpoints.form.enable_bday_points'), $errors, $rewardpoints->enable_bday_points()) }}
    </div>
</div>
<div class="row">
    <div class="col-md-8">
    {{ Form::checkbox('enable_give_old_order_points', trans('rewardpoints::attributes.enable_give_old_order_points'), trans('rewardpoints::rewardpoints.form.enable_give_old_order_points'), $errors, $rewardpoints->enable_give_old_order_points()) }}
    {{ Form::checkbox('enable_remove_points_order_refund', trans('rewardpoints::attributes.enable_remove_points_order_refund'), trans('rewardpoints::rewardpoints.form.enable_remove_points_order_refund'), $errors, $rewardpoints->enable_remove_points_order_refund()) }}
    {{ Form::number('add_days_reward_points_expiry', trans('rewardpoints::attributes.add_days_reward_points_expiry'), $errors, $rewardpoints, ['min' => 0]) }}
    {{ Form::number('add_days_reward_points_assignment', trans('rewardpoints::attributes.add_days_reward_points_assignment'), $errors, $rewardpoints, ['min' => 0]) }}
    {{ Form::number('use_points_per_order', trans('rewardpoints::attributes.use_points_per_order'), $errors, $rewardpoints, ['min' => 0]) }}
    {{ Form::number('min_order_cart_value_redemption', trans('rewardpoints::attributes.min_order_cart_value_redemption'), $errors, $rewardpoints, ['min' => 0]) }}
    </div>
</div>