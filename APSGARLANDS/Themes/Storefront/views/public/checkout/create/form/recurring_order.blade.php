<div class="recurring-order">
    <div class="row">
        <div class="col-md-18">
            <div class="form-group recurring-order-label">
                <div class="form-check">
                    <input type="checkbox" name="recurring-order" v-model="form.recurringOrder"
                        id="recurring-order">

                    <label for="recurring-order" class="form-check-label">
                        {{ trans('checkout::attributes.recurring-order') }}
                    </label>
                </div>
            </div>

            <div class="recurring-order" v-show="form.recurringOrder" v-cloak>
                <h4 class="section-title">{{ trans('storefront::checkout.recurring_order') }}</h4>
               <div class="row">
                    <div class="col-md-9">
                        <div class="form-group">
                            <label for="order-frequency">
                                {{ trans('checkout::attributes.recurring_order.order_frequency') }}<span>*</span>
                            </label>

                            <select name="billing[country]" id="order-frequency" class="form-control arrow-black"
                                @change="changeBillingCountry($event.target.value)">
                                <option value="">{{ trans('storefront::checkout.please_select') }}</option>

                                <option value="daily">Daily</option>
                                <option value="weekly">Weekly</option>
                                <option value="monthly">Monthly</option>
                            </select>

                            <span class="error-message" v-if="errors.has('billing.country')"
                                v-text="errors.get('billing.country')">
                            </span>
                        </div>
                    </div>
               </div>
            </div>
        </div>
    </div>
</div>
