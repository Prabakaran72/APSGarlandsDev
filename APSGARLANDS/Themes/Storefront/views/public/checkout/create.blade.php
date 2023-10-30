@extends('public.layout')

@section('title', trans('storefront::checkout.checkout'))

@section('content')
    <checkout-create customer-email="{{ auth()->user()->email ?? null }}"
        customer-phone="{{ auth()->user()->phone ?? null }}" :addresses="{{ $addresses }}"
        :default-address="{{ $defaultAddress }}" :gateways="{{ $gateways }}" :countries="{{ json_encode($countries) }}"
        inline-template>
        <section class="checkout-wrap">
            <div class="container">
                <template v-if="cartIsNotEmpty">
                    @include('public.cart.index.steps')
                    <form @submit.prevent="placeOrder" @input="errors.clear($event.target.name)">
                        <div class="checkout">
                            <div class="checkout-inner">
                                <div class="checkout-left">
                                    <div class="checkout-form">
                                        @include('public.checkout.create.form.account_details')
                                        @include('public.checkout.create.form.billing_details')
                                        @include('public.checkout.create.form.pickupstore_details')
                                        @include('public.checkout.create.form.delivery_details')
                                        @include('public.checkout.create.form.shipping_details')
                                        @include('public.checkout.create.form.order_note')
                                    </div>
                                </div>
                                <div class="checkout-right">
                                    @include('public.checkout.create.payment')
                                    @include('public.checkout.create.coupon')
                                </div>
                            </div>
                            @include('public.checkout.create.order_summary')
                        </div>
                    </form>
                    @if (setting('razerpay_enabled'))
                        <form ref="authorizeNetForm" method="post"
                            action="{{ setting('razerpay_enabled') ? 'https://test.authorize.net/payment/payment' : 'https://accept.authorize.net/payment/payment' }}"
                            v-if="authorizeNetToken">
                            <input type="hidden" name="token" :value="authorizeNetToken" />
                            <button type="submit"></button>
                        </form>
                    @endif
                </template>
                @include('public.cart.index.empty_cart')
            </div>
        </section>
    </checkout-create>
@endsection
