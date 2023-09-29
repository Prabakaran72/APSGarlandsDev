@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.create', ['resource' => trans('blogtag::blogtags.blogtag')]))

    <li><a href="{{ route('admin.blogtags.index') }}">{{ trans('blogtag::blogtags.blogtags') }}</a></li>
    <li class="active">{{ trans('admin::resource.create', ['resource' => trans('blogtag::blogtags.blogtag')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.blogtags.store') }}" class="form-horizontal" id="blogtag-create-form" novalidate>
        {{ csrf_field() }}
        {!! $tabs->render(compact('blogtag')) !!}
    </form>
@endsection

{{-- @include('blogtag::admin.blogtags.partials.shortcuts') --}}
