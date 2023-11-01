@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.create', ['resource' => trans('subscriber::subscribers.subscriber')]))

    <li><a href="{{ route('admin.subscribers.index') }}">{{ trans('subscriber::subscribers.subscribers') }}</a></li>
    <li class="active">{{ trans('admin::resource.create', ['resource' => trans('subscriber::subscribers.subscriber')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.subscribers.store') }}" class="form-horizontal" id="subscriber-create-form" novalidate>
        {{ csrf_field() }}

        {!! $tabs->render(compact('subscriber')) !!}
    </form>
@endsection

@include('subscriber::admin.subscribers.partials.shortcuts')
