@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.edit', ['resource' => trans('blogtag::blogtags.blogtag')]))
    @slot('subtitle', $blogtag->title)

    <li><a href="{{ route('admin.blogtags.index') }}">{{ trans('blogtag::blogtags.blogtags') }}</a></li>
    <li class="active">{{ trans('admin::resource.edit', ['resource' => trans('blogtag::blogtags.blogtag')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.blogtags.update', $blogtag) }}" class="form-horizontal" id="blogtag-edit-form" novalidate>
        {{ csrf_field() }}
        {{ method_field('put') }}

        {!! $tabs->render(compact('blogtag')) !!}
    </form>
@endsection

@include('blogtag::admin.blogtags.partials.shortcuts')
