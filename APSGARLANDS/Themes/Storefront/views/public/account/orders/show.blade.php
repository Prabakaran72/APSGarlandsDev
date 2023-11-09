@extends('public.layout')

@section('title', trans('storefront::account.view_order.view_order'))

@section('breadcrumb')
    <li><a href="{{ route('account.dashboard.index') }}">{{ trans('storefront::account.pages.my_account') }}</a></li>
    <li><a href="{{ route('account.orders.index') }}">{{ trans('storefront::account.pages.my_orders') }}</a></li>
    <li class="active">{{ trans('storefront::account.orders.view_order') }}</li>

@endsection

@section('content')
    <section class="order-details-wrap">
        <div class="container">
            <div class="order-details-top">
                <h3 class="section-title">{{ trans('storefront::account.view_order.view_order') }}
                {{-- @php
                    if ($isRecurring) {
                        echo '<a href="' . route('admin.users.edit', ['id' => $isRecurring->id]) . '" target="_blank">View Recurring Order Details</a>';
                    }
                @endphp --}}
                </h3>

                <div class="row">
                    @include('public.account.orders.show.order_information')
                    @include('public.account.orders.show.billing_address')
                    @include('public.account.orders.show.shipping_address')
                </div>
            </div>

            @include('public.account.orders.show.items_ordered')
            @include('public.account.orders.show.order_totals')
        </div>
    </section>
@endsection
