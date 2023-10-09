@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.create', ['resource' => trans('template::templates.template')]))

    <li><a href="{{ route('admin.templates.index') }}">{{ trans('template::templates.templates') }}</a></li>
    <li class="active">{{ trans('admin::resource.create', ['resource' => trans('template::templates.template')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.templates.store') }}" class="form-horizontal" id="template-create-form" novalidate>
        {{ csrf_field() }}

        {!! $tabs->render(compact('template')) !!}
    </form>
@endsection

@include('template::admin.templates.partials.shortcuts')
