@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.create', ['resource' => trans('customer::customers.customers')]))

    <li><a href="{{ route('admin.customers.index') }}">{{ trans('customer::customers.customers') }}</a></li>
    <li class="active">{{ trans('admin::resource.create', ['resource' => trans('customer::customers.customers')]) }}</li>
@endcomponent

@section('content')

{{-- <script src="./Themes/Storefront/resources/assets/js/app.js"></script> --}}
{{-- <script src="{{ mix('./Themes/Storefront/resources/assets/js/app.js') }}"></script> --}}
    <form method="POST" action="{{ route('admin.customers.store') }}" class="form-horizontal" id="customer-create-form" novalidate>
        {{ csrf_field() }}

        {{-- {!! $tabs->render(compact('customer')) !!} --}}
        <h4>{{ trans('customer::customers.customer_infromation') }}</h4><br><br>
            @include('customer::admin.customers.tabs.customerdetails')
            @include('customer::admin.customers.tabs.addressdetails')
            <div class="form-group">
                <div class="col-md-offset-3 col-md-10">
                    <button type="submit" class="btn btn-primary" data-loading>
                        {{ trans('customer::customers.buttons') }}
                    </button>
                </div>
            </div>
    </form>
@endsection

@include('customer::admin.customers.partials.shortcuts')
