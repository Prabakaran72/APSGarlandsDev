@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.edit', ['resource' => trans('blogcategory::blogcategorys.blogcategory')]))
    @slot('subtitle', $blogcategory->title)

    <li><a href="{{ route('admin.blogcategorys.index') }}">{{ trans('blogcategory::blogcategorys.blogcategorys') }}</a></li>
    <li class="active">{{ trans('admin::resource.edit', ['resource' => trans('blogcategory::blogcategorys.blogcategory')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.blogcategorys.update', $blogcategory) }}" class="form-horizontal" id="blogcategory-edit-form" novalidate>
        {{ csrf_field() }}
        {{ method_field('put') }}

        {!! $tabs->render(compact('blogcategory')) !!}
    </form>
@endsection

@include('blogcategory::admin.blogcategorys.partials.shortcuts')
