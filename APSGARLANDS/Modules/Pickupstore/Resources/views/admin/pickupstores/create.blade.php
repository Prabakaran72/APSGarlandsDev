@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.create', ['resource' => trans('pickupstore::pickupstore.pickupstore')]))

    <li><a href="{{ route('admin.pickupstores.index') }}">{{ trans('pickupstore::pickupstore.pickupstores') }}</a></li>
    <li class="active">{{ trans('admin::resource.create', ['resource' => trans('pickupstore::pickupstore.pickupstore')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.pickupstores.store') }}" class="form-horizontal" id="pickupstore-create-form" novalidate>
        {{ csrf_field() }}

        {!! $tabs->render(compact('pickupstore')) !!}
    </form>
@endsection

@include('pickupstore::admin.pickupstores.partials.shortcuts')
