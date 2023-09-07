@extends('public.layout')

@section('title', trans('storefront::cart.cart'))

@section('content')
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <cart-index inline-template v-cloak>
        <div>
            <section class="shopping-cart-wrap">
                <div class="container">
                    <template v-if="cartIsNotEmpty">
                        @include('public.cart.index.steps')

                        <div class="shopping-cart">
                            <div class="shopping-cart-inner">
                                @include('public.cart.index.cart_items')
                                @include('public.cart.index.coupon')
                            </div>

                            @include('public.cart.index.order_summary')
                        </div>
                    </template>

                    @include('public.cart.index.empty_cart')
                </div>
            </section>

            <landscape-products title="{{ trans('storefront::product.you_might_also_like') }}" v-if="hasAnyCrossSellProduct"
                :products="crossSellProducts">
            </landscape-products>
        </div>
    </cart-index>
@endsection
