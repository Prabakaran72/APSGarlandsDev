@if (setting('recurring_order_enabled'))
    <div>
        <label>
            <br><br><input type="checkbox" v-model="form.isCheckedRecurringOrder" @change="handleRecurringOrderPayment"> Recurring Order
        </label>

        <div v-if="form.isCheckedRecurringOrder">
            <div class="form-group">
                <datepicker v-model="form.recurring_order_dates" :multiple="true" :range="false"
                    :disabled-date="RecurringDisabledDates" @change="recurringDateCalc" @click="recurringDateCalc" ref="recurring_order_dates">
                </datepicker>
            </div>
            {{-- <div class="form-group">
                <label>Selected Dates:</label>
                <span>{{ recurring_selected_date_count  }}</span>
                <textarea rows="4" v-model="form.recurring_selected_date_count" class="form-control"></textarea>
                <textarea rows="4" v-model="form.recurring_format_order_dates" class="form-control"></textarea>
            </div> --}}
            <div class="form-group">
                <label>Expected Delivery Time<span>*</span></label>
                <input type="time" id="recurring_time" class="form-control" v-model="form.recurring_time"
                    ref="recurring_time">
            </div>
        </div>
    </div>
@endif