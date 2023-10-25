<div class="row">
    <div class="col-md-8">
    {{ Form::checkbox('enable_show_customer_points', trans('rewardpoints::attributes.enable_show_customer_points'), trans('rewardpoints::rewardpoints.form.enable_show_customer_points'), $errors, $rewardpoints->enable_show_customer_points()) }}
    {{ Form::checkbox('enable_show_points_with_order', trans('rewardpoints::attributes.enable_show_points_with_order'), trans('rewardpoints::rewardpoints.form.enable_show_points_with_order'), $errors, $rewardpoints->enable_show_points_with_order()) }}
    {{ Form::checkbox('enable_show_points_by_mail', trans('rewardpoints::attributes.enable_show_points_by_mail'), trans('rewardpoints::rewardpoints.form.enable_show_points_by_mail'), $errors, $rewardpoints->enable_show_points_by_mail()) }}
    </div>
</div>