@if (setting('recurring_order_enabled'))
    <div class="col-md-18">
        <div class="col-md-18">
            <label>
                <br><br><input type="checkbox" v-model="form.isCheckedRecurringOrder"
                    @change="handleRecurringOrderPayment"> Recurring Order
            </label>
        </div>
        <div class="col-md-18" v-if="form.isCheckedRecurringOrder">
            <div class="form-group d-flex">
                <div class="form-label col-md-12 pr-2 pl-3"><label>Subscription Date(s)</label></div>
                <div class="form-input pl-0">
                    <datepicker v-model="form.recurring_order_dates" :multiple="true" :range="false"
                        :disabled-date="RecurringDisabledDates" ref="recurring_order_dates">
                    </datepicker>
                </div>
            </div>
            <div class="form-group d-flex">
                <div class="form-label col-md-12 pr-2 pl-3"><label>Expected Delivery Time<span>*</span></label>
                </div>
                <div class="form-input pl-0"><input type="time" id="recurring_time"
                        class="form-control mx-input pr-2" v-model="form.recurring_time" ref="recurring_time"></div>
            </div>

            <div class="form-group d-flex">
                <div class="form-label col-md-12 pr-2 pl-3"><label>Selected Order Date<span>*</span></label>
                </div>
                <div class="form-input pl-0"><input type="time" id="recurring_time"
                        class="form-control mx-input pr-2" v-model="form.recurring_time" ref="recurring_time"></div>
            </div>

        </div>
    </div>
@endif
