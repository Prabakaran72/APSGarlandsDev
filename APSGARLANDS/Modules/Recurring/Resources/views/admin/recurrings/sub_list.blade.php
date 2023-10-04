@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('recurring::recurrings.recurringSubOrder'))

    <li class="active">{{ trans('recurring::recurrings.recurringSubOrder') }}</li>
@endcomponent

@component('admin::components.page.index_table')
{{-- <div style="display: flex; flex-direction: row;">
    <div style="flex: 0.2; text-align: left; padding-right: 15px;">
        <p>Recurring Main Id</p>
        <p>Customer Name</p>
        <p>Recurring Email</p>
        <p>Expected Delivery Time</p>
    </div>
    <div style="flex: 1; text-align: left; padding-left: 10px;">
        <p>{{ $id }}</p>
        <p>{{ $user_first_name . '   ' . $user_last_name }}</p>
        <p>{{ $user_email }}</p>
        <p>{{ $recurring_main_order->delivery_time }}</p>
    </div>
</div> --}}
    <div align="right">
        <button class="btn btn-primary" id="UnsubscribeButton"
            data-action="{{ route('unsubscribe') }}">Unsubscibe</button><br><br>
    </div>
    @slot('resource', 'recurringSubOrder')
    @slot('name', trans('recurring::recurrings.recurringSubOrder'))
    @slot('thead')

        <tr>
            <th>
                <div>
                    <input type="checkbox" id="selectAllCheckbox">
                </div>

            </th>
            <th>{{ trans('recurring::recurrings.sub_table.order_id') }}</th>
            <th>{{ trans('recurring::recurrings.sub_table.selected_date') }}</th>
            <th>{{ trans('recurring::recurrings.sub_table.delivery_date') }}</th>
            {{-- <th>{{ trans('recurring::recurrings.sub_table.main_order_id') }}</th> --}}
            <th>{{ trans('recurring::recurrings.sub_table.updated_user_id') }}</th>
            <th>{{ trans('recurring::recurrings.table.status') }}</th>
            <th data-sort>{{ trans('admin::admin.table.created') }}</th>
        </tr>
    @endslot
@endcomponent

@push('scripts')
    <script>
        DataTable.setRoutes('#recurringSubOrder-table .table', {
            index: '{{ 'admin.recurringSubOrder.index' }}',
            // edit: '{{ 'admin.recurringSubOrder.edit' }}',
        });

        $('#selectAllCheckbox').on('click', function() {
            // Get the status of the "Select All" checkbox
            var isChecked = $(this).is(':checked');

            // Select/deselect all checkboxes in the table
            // $('#recurringSubOrder-table .table tbody input[type="checkbox"]').prop('checked', isChecked);

            $('#recurringSubOrder-table .table tbody input[type="checkbox"]:not(:disabled)').prop('checked',
                isChecked);
        });
        $('#UnsubscribeButton').on('click', function() {
            // Collect selected order_id values
            var selectedOrderIds = [];
            $('#recurringSubOrder-table .table tbody input.select-checkbox:checked').each(function() {
                selectedOrderIds.push($(this).val()); // Get the value (order_id)
            });

            // Perform the unsubscribe action with the selectedOrderIds
            if (selectedOrderIds.length > 0) {
                console.log('selectedOrderIds', selectedOrderIds);
                var actionUrl = $(this).data('action');

                // Send an AJAX request to update the status
                $.ajax({
                    type: 'POST',
                    url: actionUrl,
                    data: {
                        order_ids: selectedOrderIds,
                        // Add any additional data you need to pass
                        _token: '{{ csrf_token() }}' // Add CSRF token if needed
                    },
                    success: function(response) {
                        if (response.message === 'Status updated successfully') {
                            window.location.href = window.location.href;
                        } else {
                            console.error('Error:', response.message);
                        }
                    },

                    error: function(error) {
                        console.error('Error:', error);
                    }
                });
            } else {
                alert('No items selected for unsubscribe.');
            }
        });



        new DataTable('#recurringSubOrder-table .table', {
            columns: [{
                    data: 'checkbox',
                    orderable: false,
                    searchable: false,
                    width: '3%',
                    render: function(data, type, row) {
                        // Check if current date is greater than or equal to delivery_date
                        var currentDate = new Date(); // Get the current date
                        var deliveryDate = new Date(row
                            .delivery_date); // Parse delivery_date from the row data

                        if (currentDate >= deliveryDate) {
                            checkboxHtml = '<input type="checkbox" class="select-checkbox" value="' + row
                                .order_id + '" disabled title="Delivery date has passed">';
                        } else if (row.is_active == 0) {
                            checkboxHtml = '<input type="checkbox" class="select-checkbox" value="' + row
                                .order_id + '" disabled title="You Already update Unsubscribed">';
                        } else {
                            checkboxHtml = '<input type="checkbox" class="select-checkbox" value="' + row
                                .order_id + '" title="Click to select">';
                        }

                        return checkboxHtml;

                    }
                },
                {
                    data: 'order_id'
                },
                {
                    data: 'selected_date'
                },
                {
                    data: 'delivery_date'
                },
                {
                    data: 'updated_user_id'
                },
                {
                    data: 'status',
                    name: 'is_active',
                    searchable: false
                },
                {
                    data: 'created',
                    name: 'created_at'
                },
            ],
        });
    </script>
@endpush
