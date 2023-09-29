@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.create', ['resource' => trans('blogcategory::blogcategorys.blogcategory')]))

    <li><a href="{{ route('admin.blogcategorys.index') }}">{{ trans('blogcategory::blogcategorys.blogcategorys') }}</a></li>
    <li class="active">{{ trans('admin::resource.create', ['resource' => trans('blogcategory::blogcategorys.blogcategory')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.blogcategorys.store') }}" class="form-horizontal" id="blogcategory-create-form" novalidate>
        {{ csrf_field() }}
        {!! $tabs->render(compact('blogcategory')) !!}
    </form>
@endsection

{{-- @include('blogcategory::admin.blogcategorys.partials.shortcuts') --}}
