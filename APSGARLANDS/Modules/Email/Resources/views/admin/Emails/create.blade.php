@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.create', ['resource' => trans('email::emails.email')]))

    <li><a href="{{ route('admin.emails.index') }}">{{ trans('email::emails.emails') }}</a></li>
    <li class="active">{{ trans('admin::resource.create', ['resource' => trans('email::emails.email')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.emails.store') }}" class="form-horizontal" id="email-create-form" novalidate>
        {{ csrf_field() }}

        {!! $tabs->render(compact('email')) !!}
    </form>
@endsection

@include('email::admin.emails.partials.shortcuts')
