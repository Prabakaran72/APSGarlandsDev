@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.edit', ['resource' => trans('testimonial::testimonials.testimonial')]))
    @slot('subtitle', $testimonial->user_name)

    <li><a href="{{ route('admin.testimonials.index') }}">{{ trans('testimonial::testimonials.testimonials') }}</a></li>
    <li class="active">{{ trans('admin::resource.edit', ['resource' => trans('testimonial::testimonials.testimonial')]) }}</li>
@endcomponent

@section('content')
    <form method="POST" action="{{ route('admin.testimonials.update', $testimonial) }}" class="form-horizontal" id="testimonial-edit-form" novalidate>
        {{ csrf_field() }}
        {{ method_field('put') }}

        {!! $tabs->render(compact('testimonial')) !!}
    </form>
@endsection

@include('testimonial::admin.testimonials.partials.scripts')
