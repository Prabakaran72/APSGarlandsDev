@if (setting('recurring_order_enabled'))
    <div class="col-md-18" style="border: 2px solid green">
        <div class="col-md-18">
            <label>
                <br><br><input type="checkbox" v-model="form.isCheckedRecurringOrder"
                    @change="handleRecurringOrderPayment"> Recurring Order
            </label>
        </div>
        <div class="col-md-18 row" v-if="form.isCheckedRecurringOrder">
            <div class="form-group d-flex">
                <div class="form-label"><label>Subscription Date</label></div>
                <div class="form-input">
                    <datepicker v-model="form.recurring_order_dates" :multiple="true" :range="false"
                        :disabled-date="RecurringDisabledDates" ref="recurring_order_dates">
                    </datepicker>
                </div>
            </div>
            <div class="col-md-18 row">
                <div class="form-group">
                    <div class="col-md-6"><label>Expected Delivery Time<span>*</span></label></div>
                    <div class="col-md-6"><input type="time" id="recurring_time" class="form-control"
                            v-model="form.recurring_time" ref="recurring_time"></div>
                </div>
            </div>
        </div>
    </div>
@endif
