@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.create', ['resource' => trans('rewardpoints::rewardpoints.rewardpoints')]))

    <li><a href="{{ route('admin.rewardpoints.index') }}">{{ trans('rewardpoints::rewardpoints.rewardpoints') }}</a></li>
    <li class="active">{{ trans('admin::resource.create', ['resource' => trans('rewardpoints::rewardpoints.rewardpoints')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.rewardpoints.store') }}" class="form-horizontal" id="rewardpoints-create-form" novalidate>
        {{ csrf_field() }}
        {!! $tabs->render(compact('rewardpoints')) !!}
    </form>
@endsection

@include('rewardpoints::admin.rewardpoints.partials.scripts')
