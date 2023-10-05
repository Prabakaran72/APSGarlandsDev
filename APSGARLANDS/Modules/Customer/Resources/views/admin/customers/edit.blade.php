@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.edit', ['resource' => trans('customer::customers.customers')]))
    @slot('subtitle', $customer->title)

    <li><a href="{{ route('admin.customers.index') }}">{{ trans('customer::customers.customers') }}</a></li>
    <li class="active">{{ trans('admin::resource.edit', ['resource' => trans('customer::customers.customers')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.customers.update', $customer) }}" class="form-horizontal" id="customer-edit-form" novalidate>
        {{ csrf_field() }}
        {{ method_field('put') }}

        {!! $tabs->render(compact('customer')) !!}
    </form>
@endsection

@include('customer::admin.customers.partials.shortcuts')
