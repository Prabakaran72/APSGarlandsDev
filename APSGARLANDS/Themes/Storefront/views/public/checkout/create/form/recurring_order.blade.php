@if (setting('recurring_order_enabled'))
    <div>
        <label>
            <br><br><input type="checkbox" v-model="form.isCheckedRecurringOrder" @change="handleRecurringOrderPayment"> Recurring Order
        </label>

        <div v-if="form.isCheckedRecurringOrder">
            <div class="form-group">
                <datepicker v-model="form.recurring_order_dates" :multiple="true" :range="false"
                    :disabled-date="RecurringDisabledDates"  ref="recurring_order_dates">
                </datepicker>
            </div>
            <div class="form-group">
                <label>Expected Delivery Time<span>*</span></label>
                <input type="time" id="recurring_time" class="form-control" v-model="form.recurring_time"
                    ref="recurring_time">
            </div>
        </div>
    </div>
@endif
