@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.edit', ['resource' => trans('fixedrate::fixedrates.fixedrate')]))
    @slot('subtitle', $fixedrate->title)

    <li><a href="{{ route('admin.fixedrates.index') }}">{{ trans('fixedrate::fixedrates.fixedrates') }}</a></li>
    <li class="active">{{ trans('admin::resource.edit', ['resource' => trans('fixedrate::fixedrates.fixedrate')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.fixedrates.update', $fixedrate) }}" class="form-horizontal" id="fixedrate-edit-form" novalidate>
        {{ csrf_field() }}
        {{ method_field('put') }}

        {!! $tabs->render(compact('fixedrate')) !!}
    </form>
@endsection

@include('fixedrate::admin.fixedrates.partials.shortcuts')
