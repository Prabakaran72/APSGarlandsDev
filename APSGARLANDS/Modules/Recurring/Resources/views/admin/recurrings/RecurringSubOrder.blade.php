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
    </style>


    <div style="display: flex; flex-direction: row; background-color: white; color: black; width: 50%; margin: 0 auto;">
        <div style="flex: 0.4; text-align: left; padding-right: 3px;">
            <p style="margin: 5;">Recurring Main Id</p>
            <p style="margin: 5;">Customer Name</p>
            <p style="margin: 5;">Maximum Preparing Days</p>
            <p style="margin: 5;">Customer Email</p>
            <p style="margin: 5;">Created Date</p>
            <p style="margin: 5;">Expected Delivery Time</p>

        </div>
        <div style="flex: 1; text-align: left; padding-left: 10px;">
            <p style="margin: 5;">{{ $recurringMainOrders->id }}</p>
            <p style="margin: 5;">{{ $user_first_name . '   ' . $user_last_name }}</p>
            <p style="margin: 5;">{{ $recurringMainOrders->max_preparing_days }}</p>
            <p style="margin: 5;">{{ $user_email }}</p>
            @php
                $datetimeString = $recurringMainOrders->created_at;
                $createdDate = date('Y-m-d', strtotime($datetimeString));
            @endphp
            <p style="margin: 5;">{{ $createdDate }}</p>
            @php
                $time = $recurringMainOrders->delivery_time; // '09:30:02'
                $hoursAndMinutes = substr($time, 0, 5); // Extract '09:30'
            @endphp
            <p style="margin: 5;"> {{ $hoursAndMinutes }}</p>
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
                <th>S.NO</th>
                <th>Order Id</th>
                <th>Order Date</th>
                <th>Delivery Date</th>
                <th>Order Details</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            @php
                $sno = 1; // Initialize the serial number counter
            @endphp
            @foreach ($recurringSubOrders as $sub_data)
                <tr>
                    <td>
                        <input type="checkbox" class="rowCheckbox" value="{{ $sub_data->order_id }}"
                            {{ strtotime($sub_data->delivery_date) <= strtotime(date('Y-m-d')) || $sub_data->is_active == 0 ? 'disabled' : '' }}
                            title="<?php
                            if (strtotime($sub_data->delivery_date) <= strtotime(date('Y-m-d'))) {
                                echo 'Delivery date has passed';
                            } elseif ($sub_data->is_active == 0) {
                                echo 'You Already update Unsubscribed';
                            } else {
                                echo 'Click to select';
                            }
                            ?>">
                    </td>
                    <td>{{ $sno }}</td>
                    <td>{{ $sub_data->order_id }}</td>
                    <td>{{ $sub_data->selected_date }}</td>
                    <td>{{ $sub_data->delivery_date }}</td>
                    <td>
                        <a href="{{ route('admin.users.edit', ['id' => $recurringMainOrders->created_user_id]) }}"
                            target="_blank">Edit User</a>

                        {{-- <a href="{{ route('admin.orders.show', ['id' => $recurringMainOrders->order_id]) }}" target="_blank">View Order Details</a> --}}
                    </td>
                    <td>
                        @if ($sub_data->is_active == 1)
                            <span class="dot green"></span>
                        @else
                            <span class="dot red"></span>
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

{{-- @include('recurring::admin.recurrings.partials.scripts') --}}


<script>
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
        // Get all selected checkboxes
        const selectedCheckboxes = document.querySelectorAll('.rowCheckbox:checked');

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
                    order_ids: selectedOrderIds
                },
                success: function(response) {
                    // Handle the response from the controller here
                    console.log("sangeetha 1 ", response);


                    window.location.reload();

                },
                error: function(error) {
                    // Handle any errors here
                    console.error("sangeetha 0 ", error);
                }
            });
        } else {
            console.log("please Select");
        }
    }
</script>

{{-- // overallUnsubscribeButton.addEventListener('click', function() {
    //     const selectedIds = [];

    //     // Collect the selected checkbox values
    //     rowCheckboxes.forEach(function(checkbox) {
    //         if (checkbox.checked) {
    //             selectedIds.push(checkbox.value);
    //         }
    //     });

    //     // Get the route URL and CSRF token from the button's data attributes
    //     const routeUrl = overallUnsubscribeButton.getAttribute('data-route');
    //     const csrfToken = '{{ csrf_token() }}';

    //     // Send an AJAX request to the server
    //     if (selectedIds.length > 0) {
    //         fetch(routeUrl, {
    //                 method: 'POST',
    //                 headers: {
    //                     'Content-Type': 'application/json',
    //                     'X-CSRF-TOKEN': csrfToken,
    //                 },
    //                 body: JSON.stringify({
    //                     selectedIds: selectedIds
    //                 }),
    //             })
    //             .then(response => response.json())
    //             .then(data => {
    //                 if (data.success) {
    //                     // Handle success, e.g., reload the page or update UI
    //                     location.reload(); // For simplicity, you can reload the page
    //                 } else {
    //                     // Handle failure
    //                     console.error('Failed to unsubscribe selected items.');
    //                 }
    //             })
    //             .catch(error => {
    //                 console.error('Error:', error);
    //             });
    //     } else {
    //         alert('Please select at least one item to unsubscribe.');
    //     }
    // }); --}}

{{-- // Add a click event listener to the "Overall Unsubscribe" button
        // overallUnsubscribeButton.addEventListener('click', function() {
        //     const selectedRowIds = [];

        //     // Iterate through row checkboxes to find the selected ones and collect their IDs
        //     rowCheckboxes.forEach(function(checkbox) {
        //         if (checkbox.checked) {
        //             // Extract the row ID from the checkbox value (assuming you set it as the value)
        //             selectedRowIds.push(checkbox.value);
        //         }
        //     });

        //     // Make an AJAX request to update the status for the selected rows
        //     fetch('{{ route('admin.recurringSubOrder.unsubscribe') }}', {
        //             method: 'POST',
        //             headers: {
        //                 'Content-Type': 'application/json',
        //                 'X-CSRF-TOKEN': '{{ csrf_token() }}', // Include the CSRF token
        //             },
        //             body: JSON.stringify({
        //                 selectedRowIds: selectedRowIds, // Send the selected row IDs as JSON data
        //             }),
        //         })
        //         .then(response => response.json())
        //         .then(data => {
        //             // Handle the response data, if needed
        //             console.log('Update Status Response:', data);
        //             return
        //             // Optionally, you can redirect to another page or update the UI based on the response
        //         })
        //         .catch(error => {
        //             console.error('Error updating status:', error);
        //         });
        // }); --}}
