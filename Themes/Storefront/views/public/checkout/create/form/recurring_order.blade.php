@if (setting('recurring_order_enabled'))
    <div>
        <input type="checkbox" id="recurring_details_btn" onclick="show_recurring_details()"> Recurring Order
    </div>

    <div id="recurring_details" style="display: none">
        <div class="col-md-6">
            {{-- recurring_frequency recurring_day recurring_date recurring_start_date recurring_end_date recurring_time --}}
            <div class="form-group">
                <label for="recurring_frequency">Frequency</label>
                <select name="recurring_frequency" id="recurring_frequency" class="form-control"
                    onclick="show_recurring_days()">
                    <option value="Daily">Daily</option>
                    <option value="Weekly">Weekly</option>
                    <option value="Monthly">Monthly</option>
                </select>
            </div>

            <div class="form-group" id="day_options" style="display: none;" >
                <label for="recurring_day">Select a day</label>
                <select name="recurring_day" id="recurring_day" class="form-control">
                    <option value="Monday">Monday</option>
                    <option value="Tuesday">Tuesday</option>
                    <option value="Wednesday">Wednesday</option>
                    <option value="Thursday">Thursday</option>
                    <option value="Friday">Friday</option>
                    <option value="Saturday">Saturday</option>
                    <option value="Sunday">Sunday</option>
                </select>
            </div>

            <div class="form-group" id="date_options" style="display: none;">
                <label for="recurring_date">Select a date</label>
                <select name="recurring_date" id="recurring_date" class="form-control">
                    <!-- Options for selecting days from 1 to 30 -->
                    @for ($i = 1; $i <= 30; $i++)
                        <option value="{{ $i }}">{{ $i }}</option>
                    @endfor
                </select>
            </div>

            <div class="form-group">
                <label for="recurring_start_date">Start Date</label>
                <input type="date" id="recurring_start_date" name="recurring_start_date" class="form-control">
            </div>

            <div class="form-group">
                <label for="recurring_end_date">End Date</label>
                <input type="date" id="recurring_end_date" name="recurring_end_date" class="form-control">
            </div>

            <div class="form-group">
                <label for="recurring_time">Time</label>
                <input type="time" id="recurring_time" name="recurring_time" class="form-control">
            </div>

        </div>
    </div>
@endif
