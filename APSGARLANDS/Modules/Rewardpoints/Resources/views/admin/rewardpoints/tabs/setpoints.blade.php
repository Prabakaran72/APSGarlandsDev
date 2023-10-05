<div class="row">
    <div class="col-md-8">
        {{trans('rewardpoints::attributes.set_points_for_all_user')}}
    </div>
</div>
<HR/>

<div class="row">
    <div class="col-md-4">
        {{ Form::number('currency_value', trans('rewardpoints::attributes.currency_value'), $errors, $rewardpoints, ['min' => 0]) }}
    </div>
    <div class="col-md-4">
        {{ Form::number('point_value', trans('rewardpoints::attributes.point_value'), $errors, $rewardpoints, ['min' => 0]) }}
    </div>
</div>
<div class="row" style="heighht:15px !important;"></div>
<div class="row">
    <div class="col-md-8">
        {{trans('rewardpoints::attributes.set_redeem_points')}}
    </div>
</div>
<HR/>
<div class="row">
    <div class="col-md-4">
        {{ Form::number('redemption_point_value', trans('rewardpoints::attributes.redemption_point_value'), $errors, $rewardpoints, ['min' => 0]) }}
    </div>
    <div class="col-md-4">
        {{ Form::number('redemption_currency_value', trans('rewardpoints::attributes.redemption_currency_value'), $errors, $rewardpoints, ['min' => 0]) }}
    </div>
</div>
<div class="row" style="heighht:15px !important;"></div>
<div class="row">
    <div class="col-md-8">
        {{trans('rewardpoints::attributes.set_extra_points')}}
    </div>
</div>
<HR/>
<div class="row">
    <div class="col-md-4">
        {{ Form::number('epoint_first_signup_value', trans('rewardpoints::attributes.epoint_first_signup_value'), $errors, $rewardpoints, ['min' => 0]) }}
    </div>
    {{-- <div class="col-md-4">
        {{ Form::number('epoint_ref_point_value', trans('rewardpoints::attributes.epoint_ref_point_value'), $errors, $rewardpoints, ['min' => 0]) }}
    </div> --}}
    <div class="col-md-4">
        {{ Form::number('epoint_forder_point_value', trans('rewardpoints::attributes.epoint_forder_point_value'), $errors, $rewardpoints, ['min' => 0]) }}
    </div>
    <div class="col-md-4">
        {{ Form::number('epoint_freview_point_value', trans('rewardpoints::attributes.epoint_freview_point_value'), $errors, $rewardpoints, ['min' => 0]) }}
    </div>
    <div class="col-md-4">
        {{ Form::number('epoint_fpay_point_value', trans('rewardpoints::attributes.epoint_fpay_point_value'), $errors, $rewardpoints, ['min' => 0]) }}
    </div>
    <div class="col-md-4">
        {{ Form::number('epoint_bday_point_value', trans('rewardpoints::attributes.epoint_bday_point_value'), $errors, $rewardpoints, ['min' => 0]) }}
    </div>
</div>