@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.edit', ['resource' => trans('subscriber::subscribers.subscriber')]))
    @slot('subtitle', $subscriber->title)

    <li><a href="{{ route('admin.subscribers.index') }}">{{ trans('subscriber::subscribers.subscribers') }}</a></li>
    <li class="active">{{ trans('admin::resource.edit', ['resource' => trans('subscriber::subscribers.subscriber')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.subscribers.update', $subscriber) }}" class="form-horizontal" id="subscriber-edit-form" novalidate>
        {{ csrf_field() }}
        {{ method_field('put') }}

        {!! $tabs->render(compact('subscriber')) !!}
    </form>
@endsection

@include('subscriber::admin.subscribers.partials.shortcuts')
