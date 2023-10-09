@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.edit', ['resource' => trans('template::templates.template')]))
    @slot('subtitle', $template->title)

    <li><a href="{{ route('admin.templates.index') }}">{{ trans('template::templates.templates') }}</a></li>
    <li class="active">{{ trans('admin::resource.edit', ['resource' => trans('template::templates.template')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.templates.update', $template) }}" class="form-horizontal" id="template-edit-form" novalidate>
        {{ csrf_field() }}
        {{ method_field('put') }}

        {!! $tabs->render(compact('template')) !!}
    </form>
@endsection

@include('template::admin.templates.partials.shortcuts')
