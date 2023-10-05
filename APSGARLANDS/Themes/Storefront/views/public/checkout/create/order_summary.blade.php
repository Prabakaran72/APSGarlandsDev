<aside class="order-summary-wrap">
    <div class="order-summary">
        <div class="order-summary-top">
            <h3 class="section-title">{{ trans('storefront::cart.order_summary') }}</h3>

            <ul class="list-inline cart-item">
                <li v-for="cartItem in cart.items">
                    <label>
                        <a :href="productUrl(cartItem.product)" class="product-name" v-text="cartItem.product.name"></a>
                        <span class="product-quantity" v-text="'x' + cartItem.qty"></span>
                    </label>

                    <span class="price-amount" v-html="cartItem.unitPrice.inCurrentCurrency.formatted"></span>
                </li>
            </ul>
        </div>

        <div class="order-summary-middle" :class="{ loading: loadingOrderSummary }">
            <ul class="list-inline order-summary-list">
                <li>
                    <label>{{ trans('storefront::cart.subtotal') }}</label>

                    <span class="price-amount" v-html="cart.subTotal.inCurrentCurrency.formatted">
                    </span>
                </li>
                <li v-if="hasCoupon" v-cloak>
                    <label>
                        {{ trans('storefront::cart.coupon') }}
                        <span class="coupon-code">
                            [@{{ cart.coupon.code }}]
                            <span class="btn-remove-coupon" @click="removeCoupon">
                                <i class="las la-times"></i>
                            </span>
                        </span>
                    </label>
                    <span class="price-amount" v-html="'-' + cart.coupon.value.inCurrentCurrency.formatted">
                    </span>
                </li>
            </ul>

            <div class="shipping-methods" v-if="hasShippingMethod" v-cloak>
                <h6>{{ trans('storefront::cart.shipping_method') }}</h6>

                <div class="form-group">
                    <div class="form-radio" v-for="shippingMethod in cart.availableShippingMethods">
                        <input type="radio" name="shipping_method" v-model="form.shipping_method"
                            :value="shippingMethod.name" :id="shippingMethod.name"
                            @change="updateShippingMethod(shippingMethod.name)">
                        <label :for="shippingMethod.name" v-text="shippingMethod.label"></label>
                
                        <!-- Use a data-bound id attribute to set the id dynamically -->
                        <span :id="'price_' + shippingMethod.name" class="price-amount" v-html="shippingMethod.cost.inCurrentCurrency.formatted">
                        </span>
                        
                    </div>
                    <span id="pincode_not_servicable" class="pincode-message" style="display: none;"> This Pincode not serviceable for flat rate shippment Option</span>
                </div>
                
                {{-- <div v-if="form.shipping_method== 'flat_rate'" > --}}
                <div class="order-summary-total">
                    <label>{{ trans('storefront::cart.total') }}</label>
                    <!-- Remove single quotes around the id attribute value -->
                    <span :id="'total_' + form.shipping_method" class="total-price" v-html="cart.total.inCurrentCurrency.formatted"></span>
                    
                </div>
                {{-- </div> --}}
                
        </div>

        <div class="order-summary-bottom">
            <div class="form-group checkout-terms-and-conditions">
                <div class="form-check">
                    <input type="checkbox" v-model="form.terms_and_conditions" id="terms-and-conditions" :disabled="shouldDisableCheckbox">
                    {{-- <input type="checkbox" v-model="form.terms_and_conditions" id="terms-and-conditions" :disabled="form.shipping_method === 'flat_rate' && !serviceAvailable"> --}}
                    <label for="terms-and-conditions" class="form-check-label">
                        {{ trans('storefront::checkout.i_agree_to_the') }}
                        {{-- <a href="{{ $termsPageURL }}">
                            {{ trans('storefront::checkout.terms_&_conditions') }}
                        </a> --}}
                        <a href="#" data-bs-toggle="modal" data-bs-target="#showTermsModal" id="termslink" @click.prevent="openModal('{{ $termsPageURL }}')"> {{ trans('storefront::checkout.terms_&_conditions') }} </a>
                    </label>

                    <span class="error-message" v-if="errors.has('terms_and_conditions')"
                        v-text="errors.get('terms_and_conditions')"></span>
                </div>
            </div>

            <div id="paypal-button-container" v-if="form.payment_method === 'paypal'"></div>

            <button type="submit" class="btn btn-primary btn-place-order" :class="{ 'btn-loading': placingOrder }"
                :disabled="!form.terms_and_conditions" v-else v-cloak>
                {{ trans('storefront::checkout.place_order') }}
            </button>
        </div>
    </div>
</aside>


<div class="modal fade" id="terms-modal">
    <div class="modal-dialog" role="document">
        <div class="modal-content" class="px-1">
            {{-- <div class="modal-header">
                <button type="button" class="btn btn-outline-danger mt-3" data-bs-dismiss="modal"><i class="fa fa-times-circle" aria-hidden="true"></i></button>
            </div> --}}
            <div class="modal-body">
                <div v-html="termsModalContent" class="termsmodalcontent"></div>
            </div>
            <div class="modal-footer">
              {{-- <button type ="button" class="btn btn-primary" @click.prevent="acceptTerms()">Accept</button> --}}
              <button type ="button" class="btn btn-primary" @click.prevent="hideTermsModal()" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
