@extends('admin::layout')

@component('admin::components.page.header_customer_reward')
    @slot('title', trans('rewardpointsgift::rewardpointsgifts.title_new', ['resource' =>
        trans('rewardpointsgift::rewardpointsgifts.title_new')]))

        <li class="pointer"><a
                href="{{ route('admin.rewardpointsgift.index') }}">{{ trans('rewardpointsgift::rewardpointsgifts.title') }}</a>
        </li>

        <li><a
                href="{{ route('admin.rewardpointsgift.edit', ['id' => $customer->id]) }}">{{ trans('rewardpointsgift::rewardpointsgifts.rewardpointsgifts') }}</a>
        </li>
        <li class="active">
            {{ trans('admin::resource.create', ['resource' => trans('rewardpointsgift::rewardpointsgifts.button.create')]) }}
        </li>
    @endcomponent

    @section('content')
        <form method="POST" action="{{ route('admin.rewardpointsgift.store')}}" class="form-horizontal"
            id="rewardpointsgift-add-new-form">
            {{ csrf_field() }}
            <div class="row">
                <div class="col-md-8">
                    <div class="form-group"><label for='rewardpointsgifted_name' class='col-md-3 control-label text-left'>
                            {{ trans('rewardpointsgift::attributes.customer_name') }}</label>
                        <div class='col-md-9'><input name='rewardpointsgifted_name' class='form-control '
                                id='rewardpointsgifted_name' value="{{ $customer->full_name }}" type='text' disabled
                                {'@readonly(true)'}></div>
                        <!-- Add a hidden input field for customer_id -->
                    </div>
                    <input type="hidden" name="customer_id" value="{{ $customer->id}}">

                    {{ Form::number('reward_point_value', trans('rewardpointsgift::attributes.reward_point_value'), $errors, $customer, ['required' => true]) }}
                    {{ Form::textarea('reward_point_remarks', trans('rewardpointsgift::attributes.reward_point_remarks'), $errors, $customer, ['rows' => 3, 'maxlength' => 100]) }}
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
