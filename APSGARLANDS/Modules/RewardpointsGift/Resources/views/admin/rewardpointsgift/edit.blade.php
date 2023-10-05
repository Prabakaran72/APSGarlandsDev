@extends('admin::layout')

@component('admin::components.page.header_customer_reward')
    @slot('title', trans('admin::resource.edit', ['resource' => trans('rewardpointsgift::rewardpointsgifts.title')]))
    
    <li class="pointer"><a
        href="{{ route('admin.rewardpointsgift.index')}}">{{ trans('rewardpointsgift::rewardpointsgifts.title') }}</a>
    </li>

    <li><a href="{{ route('admin.rewardpointsgift.edit',['id'=>$rewardpointsgifted->user_id]) }}">{{ trans('rewardpointsgift::rewardpointsgifts.customer_wise_allocation') }}</a></li>
    <li class="active">{{ trans('admin::resource.edit', ['resource' => trans('rewardpointsgift::rewardpointsgifts.rewardpointsgift')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.rewardpointsgift.update', $rewardpointsgifted->id)}}" class="form-horizontal" id="rewardpointsgift-edit-form" novalidate>
        {{ csrf_field() }}
        {{ method_field('put') }}

        <div class="row">
            <div class="col-md-8">
                <div class="form-group"><label for='rewardpointsgifted_name' class='col-md-3 control-label text-left'> {{ trans('rewardpointsgift::attributes.customer_name')}}</label><div class='col-md-9'><input
                    name='rewardpointsgifted_name'
                    class='form-control '
                    id='rewardpointsgifted_name'
                    value = "{{ $rewardpointsgifted->user->full_name }}"
                    type='text' disabled {'@readonly(true)'} ></div></div>

                {{ Form::number('reward_point_value', trans('rewardpointsgift::attributes.reward_point_value'), $errors, $rewardpointsgifted, [] ) }}
                {{ Form::textarea('reward_point_remarks', trans('rewardpointsgift::attributes.reward_point_remarks'), $errors, $rewardpointsgifted,['rows' => 3, 'maxlength'=>100]) }}
               
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
