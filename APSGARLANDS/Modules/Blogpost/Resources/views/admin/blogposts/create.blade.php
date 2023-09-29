@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.create', ['resource' => trans('blogpost::blogposts.blogpost')]))

    <li><a href="{{ route('admin.blogposts.index') }}">{{ trans('blogpost::blogposts.blogposts') }}</a></li>
    <li class="active">{{ trans('admin::resource.create', ['resource' => trans('blogpost::blogposts.blogpost')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.blogposts.store') }}" class="form-horizontal" id="blogpost-create-form" novalidate>
        {{ csrf_field() }}
        {!! $tabs->render(compact('blogpost')) !!}
    </form>
@endsection

{{-- @include('blogpost::admin.blogposts.partials.shortcuts') --}}
