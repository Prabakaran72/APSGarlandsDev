@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.create', ['resource' => trans('fixedrate::fixedrates.fixedrate')]))

    <li><a href="{{ route('admin.fixedrates.index') }}">{{ trans('fixedrate::fixedrates.fixedrates') }}</a></li>
    <li class="active">{{ trans('admin::resource.create', ['resource' => trans('fixedrate::fixedrates.fixedrate')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.fixedrates.store') }}" class="form-horizontal" id="fixedrate-create-form" novalidate>
        {{ csrf_field() }}

        {!! $tabs->render(compact('fixedrate')) !!}
    </form>
@endsection

@include('fixedrate::admin.fixedrates.partials.shortcuts')
