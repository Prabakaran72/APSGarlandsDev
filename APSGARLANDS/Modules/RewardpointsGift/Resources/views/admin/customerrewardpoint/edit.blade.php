@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.edit', ['resource' => trans('rewardpointsgift::rewardpointsgifts.rewardpointsgift')]))
    {{-- @slot('subtitle', $rewardpointsGift->name) --}}

    <li><a href="{{ route('admin.rewardpointsgift.index') }}">{{ trans('rewardpointsgift::rewardpointsgifts.rewardpointsgift') }}</a></li>
    <li class="active">{{ trans('admin::resource.edit', ['resource' => trans('rewardpointsgift::rewardpointsgifts.rewardpointsgift')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.rewardpointsgift.update', $customer->id)}}" class="form-horizontal" id="rewardpointsgift-edit-form" novalidate>
        {{ csrf_field() }}
        {{ method_field('put') }}

        <div class="row">
            <div class="col-md-8">
                <div class="form-group"><label for='customer_name' class='col-md-3 control-label text-left'> {{ trans('rewardpointsgift::attributes.customer_name')}}</label><div class='col-md-9'><input
                    name='customer_name'
                    class='form-control '
                    id='customer_name'
                    value="{{ucfirst($customer->first_name).' '.ucfirst($customer->last_name)}}"
                    type='text' disabled {'@readonly(true)'} ></div></div>

                {{ Form::number('reward_point_value', trans('rewardpointsgift::attributes.reward_point_value'), $errors, $rewardpointsGift, [] ) }}
                {{ Form::textarea('reward_point_remarks', trans('rewardpointsgift::attributes.reward_point_remarks'), $errors, $rewardpointsGift,['rows' => 3, 'maxlength'=>100]) }}
               
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <button type="submit" class="btn btn-primary" data-loading id="rewardpointsupdate">
                    {{ trans('admin::admin.buttons.save') }}
                </button>
            </div>
        </div>

    </form>
@endsection

@include('rewardpointsgift::admin.rewardpointsgift.partials.shortcuts')
