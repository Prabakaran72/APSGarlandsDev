@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.edit', ['resource' => trans('email::emails.email')]))
    @slot('subtitle', $email->title)

    <li><a href="{{ route('admin.emails.index') }}">{{ trans('email::emails.emails') }}</a></li>
    <li class="active">{{ trans('admin::resource.edit', ['resource' => trans('email::emails.email')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.emails.update', $email) }}" class="form-horizontal" id="email-edit-form" novalidate>
        {{ csrf_field() }}
        {{ method_field('put') }}

        {!! $tabs->render(compact('email')) !!}
    </form>
@endsection

@include('email::admin.emails.partials.shortcuts')
