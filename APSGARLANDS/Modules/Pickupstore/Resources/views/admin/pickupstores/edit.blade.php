@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.edit', ['resource' => trans('pickupstore::pickupstore.pickupstore')]))
    @slot('subtitle', $pickupstore->title)

    <li><a href="{{ route('admin.pickupstores.index') }}">{{ trans('pickupstore::pickupstore.pickupstores') }}</a></li>
    <li class="active">{{ trans('admin::resource.edit', ['resource' => trans('pickupstore::pickupstore.pickupstore')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.pickupstores.update', $pickupstore) }}" class="form-horizontal" id="pickupstore-edit-form" novalidate>
        {{ csrf_field() }}
        {{ method_field('put') }}

        {!! $tabs->render(compact('pickupstore')) !!}
    </form>
@endsection

@include('pickupstore::admin.pickupstores.partials.shortcuts')
