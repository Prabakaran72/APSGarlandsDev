@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('admin::resource.edit', ['resource' => trans('recurring::recurrings.recurring')]))
    @slot('subtitle', $recurringMainOrders->id)

    <li><a href="{{ route('admin.recurrings.index') }}">{{ trans('recurring::recurrings.recurrings') }}</a></li>
    <li class="active">{{ trans('admin::resource.edit', ['resource' => trans('recurring::recurrings.recurring')]) }}</li>
@endcomponent

@section('content')
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            border: 1px solid #eeeef4;
            padding: 10px;
            background-color: #ffffff;
            /* Set the background color for th elements */
            color: rgb(116, 114, 114);
            /* Set the text color for th elements */
        }

        td {
            border: 1px solid #eeeef4;
            padding: 10px;
            background-color: white;
            /* Set the background color to white */
            color: rgb(29, 27, 27);
            /* Set the text color to black */
        }

        th {
            background-color: #ffffff;
        }

        .success-message {
            background-color: #d4edda;
            /* Green color for success */
            border-color: #c3e6cb;
            color: #155724;
            padding: 10px;
            border-radius: 5px;
            margin-top: 10px;
        }
    </style>

    <div id="success-message" class="success-message" style="display: none;">
        Order Status Updated Successfully
    </div>

    <div style="display: flex; flex-direction: row; background-color: white; color: black; width: 50%; margin: 0 auto;">
        <div style="flex: 0.6; text-align: left; padding-right: 3px;">
            {{-- <p style="margin: 5;">Recurring Main Id</p> --}}
            <p style="margin: 5;">Order Id</p>
            <p style="margin: 5;">Recurring Order Count</p>
            <p style="margin: 5;">Maximum Preparing Days</p>
            <p style="margin: 5;">Expected Delivery Time</p>
            <p style="margin: 5;">Created Date</p>

        </div>
        <div style="flex: 1; text-align: left; padding-left: 10px;">
            {{-- <p style="margin: 5;">{{ $recurringMainOrders->id }}</p> --}}
            <p style="margin: 5;">{{ $recurringMainOrders->order_id }}
                <a href="{{ route('admin.orders.show', ['id' => $recurringMainOrders->order_id]) }}" target="_blank">View
                    Order Details</a>
            </p>
            <p style="margin: 5;">{{ $recurringMainOrders->recurring_date_count }}</p>
            <p style="margin: 5;">{{ $recurringMainOrders->max_preparing_days }}</p>
            @php
                $time = $recurringMainOrders->delivery_time; // '09:30:02'
                $hoursAndMinutes = substr($time, 0, 5); // Extract '09:30'
            @endphp
            <p style="margin: 5;"> {{ $hoursAndMinutes }}</p>
            @php
                $datetimeString = $recurringMainOrders->created_at;
                $createdDate = date('Y-m-d', strtotime($datetimeString));
            @endphp
            <p style="margin: 5;">{{ $createdDate }}</p>

        </div>
    </div>


    <br>
    <div align="right">
        <button class="btn btn-primary" id="overallUnsubscribeButton"
            onclick="unsubscribeMultipleOrders()">Unsubscribe</button>
    </div>
    <br>

    <table class="table">
        <thead>
            <tr>
                <th><input type="checkbox" id="selectAllCheckbox" class="select-all-checkbox"></th>
                <th>Id</th>
                {{-- <th>Recurring Id</th> --}}
                <th>Selected Date</th>
                {{-- <th>Updated User Id</th> --}}
                <th>Subscribe Status</th>
                <th>Order Status</th>
            </tr>
        </thead>
        <tbody>
            @php
                $sno = 1; // Initialize the serial number counter
            @endphp
            @foreach ($recurringSubOrders as $sub_data)
                @php
                    // dd($sub_data);
                @endphp
                <tr>
                    <td>
                        <input type="checkbox" class="rowCheckbox" value="{{ $sub_data->id }}"
                            {{ strtotime($sub_data->selected_date) <= strtotime(date('Y-m-d')) || $sub_data->subscribe_status == 0 ? 'disabled' : '' }}
                            title="<?php
                            if (strtotime($sub_data->selected_date) <= strtotime(date('Y-m-d'))) {
                                echo 'Delivery date has passed';
                            } elseif ($sub_data->subscribe_status == 0) {
                                echo 'You Already update Unsubscribed';
                            } else {
                                echo 'Click to select';
                            }
                            ?>">
                    </td>
                    <td>{{ $sub_data->id }}</td>

                    <td>{{ $sub_data->selected_date }}</td>

                    <td>
                        @if ($sub_data->subscribe_status == 1)
                            <span class="dot green"></span>
                        @else
                            <span class="dot red"></span>
                        @endif
                    </td>
                    <td>
                        @if (($sub_data->order_status == 'Unsubscribed') || $sub_data->order_status == '')
                            {{ $sub_data->order_status }}
                        @else
                            <select name="order_status" id="order_status"
                                onchange="updateOrderStatus(<?php echo $sub_data->id; ?>, this.value)">

                                @foreach (trans('order::statuses') as $name => $label)
                                    <option value="{{ $name }}"
                                        {{ $sub_data->order_status === $name ? 'selected' : '' }}>{{ $label }}
                                    </option>
                                @endforeach
                            </select>
                        @endif
                    </td>
                </tr>
                @php
                    $sno++; // Increment the serial number counter
                @endphp
            @endforeach
        </tbody>
    </table>


    <div class="pull-right">
        {!! $recurringSubOrders->links() !!}
    </div>


    </div>
@endsection

<script>
    function redirectToRoute(selectedValue) {
        // Construct the URL using the selected value and redirect
        window.location.href = "{{ route('admin.recurrings.unsubscribeMultipleOrder') }}" + "?order_status=" +
            selectedValue;
    }

    document.addEventListener('DOMContentLoaded', function() {
        const selectAllCheckbox = document.getElementById('selectAllCheckbox');
        const rowCheckboxes = document.querySelectorAll('.rowCheckbox');
        const overallUnsubscribeButton = document.getElementById('overallUnsubscribeButton');

        // Add a click event listener to the "Select All" checkbox
        selectAllCheckbox.addEventListener('click', function() {
            // Iterate through all row checkboxes and set their checked state to match the "Select All" checkbox
            rowCheckboxes.forEach(function(checkbox) {
                if (!checkbox.disabled) {
                    checkbox.checked = selectAllCheckbox.checked;
                }
            });
        });

    });

    function unsubscribeMultipleOrders() {

        // Get a reference to the "Unsubscribe" button
        const overallUnsubscribeButton = document.getElementById('overallUnsubscribeButton');

        // Disable the button to prevent further clicks
        overallUnsubscribeButton.disabled = true;

        // Get all selected checkboxes
        const selectedCheckboxes = document.querySelectorAll('.rowCheckbox:checked');
        overallUnsubscribeButton

        // Create an array to store the values of selected checkboxes
        const selectedOrderIds = [];

        selectedCheckboxes.forEach(function(checkbox) {
            selectedOrderIds.push(checkbox.value);
        });

        if (selectedOrderIds.length > 0) {
            // Make an AJAX request to your controller
            $.ajax({
                url: '{{ route('admin.recurrings.unsubscribeMultipleOrder') }}',
                type: 'POST',
                data: {
                    selectedIds: selectedOrderIds
                },
                success: function(response) {
                    if(response.success){
                        window.location.reload();
                        // overallUnsubscribeButton.disabled = false;
                    }
                },
                error: function(error) {
                    // overallUnsubscribeButton.disabled = false;
                    console.error(error);
                }
            });
        } else {
            console.log("please Select");
            overallUnsubscribeButton.disabled = false;
        }
    }

    function updateOrderStatus(sub_id, order_status) {

        $.ajax({
            type: 'POST',
            url: '{{ route('admin.recurrings.updateOrderStatus') }}',
            data: {
                sub_id: sub_id,
                order_status: order_status
            },
            success: function(response) {
                // Handle the response from the controller here
                if (response.success) {
                    // Show success message
                    // Assuming you have a div with id="success-message" to display success messages
                    $('#success-message').show();
                    // Assuming you want to hide the success message after a certain time (e.g., 3 seconds)
                    setTimeout(function() {
                        $('#success-message').hide();
                    }, 3000);
                }else{
                    console.log(response.error);
                    $('#success-message').hide();
                }
            },
            error: function(error) {
                console.error(error);
            }
        });
    }
</script>
