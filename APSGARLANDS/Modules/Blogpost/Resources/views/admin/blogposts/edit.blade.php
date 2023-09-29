@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.edit', ['resource' => trans('blogpost::blogposts.blogpost')]))
    @slot('subtitle', $blogpost->title)

    <li><a href="{{ route('admin.blogposts.index') }}">{{ trans('blogpost::blogposts.blogposts') }}</a></li>
    <li class="active">{{ trans('admin::resource.edit', ['resource' => trans('blogpost::blogposts.blogpost')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.blogposts.update', $blogpost) }}" class="form-horizontal" id="blogpost-edit-form" novalidate>
        {{ csrf_field() }}
        {{ method_field('put') }}

        {!! $tabs->render(compact('blogpost')) !!}
    </form>
@endsection

@include('blogpost::admin.blogposts.partials.shortcuts')
