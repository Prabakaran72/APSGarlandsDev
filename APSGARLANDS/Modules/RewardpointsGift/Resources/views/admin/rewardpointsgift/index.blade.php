@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('rewardpointsgift::rewardpointsgifts.title'))

    <li class="active">{{ trans('rewardpointsgift::rewardpointsgifts.title') }}</li>
@endcomponent

@component('admin::components.page.index_table')
    @slot('resource', 'rewardpointsgift')
    @slot('name', trans('rewardpointsgift::rewardpointsgifts.rewardpointsgift'))

    @component('admin::components.table')
        @slot('thead')
            <tr>
                @include('admin::partials.table.select_all')
                <th>{{ trans('rewardpointsgift::rewardpointsgifts.table.customer_name') }}</th>
                <th>{{ trans('rewardpointsgift::rewardpointsgifts.table.email') }}</th>
                <th>{{ trans('rewardpointsgift::rewardpointsgifts.table.order_count') }}</th>
                <th>{{ trans('rewardpointsgift::rewardpointsgifts.table.total_order_amount') }}</th>
                <th>{{ trans('rewardpointsgift::rewardpointsgifts.table.reward_point_value') }}</th>
            </tr>
        @endslot
    @endcomponent
@endcomponent


@push('scripts')
    <script>
        new DataTable('#rewardpointsgift-table .table', {
            columns: [{
                    data: 'checkbox',
                    orderable: false,
                    searchable: false,
                    width: '5%'
                },
                {
                    data: null, // Use null as the data source since we're not directly binding to a single attribute
                    render: function(data, type, row) {
                        const capitalizedFirstName = row.first_name.charAt(0).toUpperCase() + row.first_name
                            .slice(1);
                        const capitalizedLastName = row.last_name.charAt(0).toUpperCase() + row.last_name
                            .slice(1);
                        if (type === 'display') {
                            // Concatenate first_name and last_name attributes
                            return capitalizedFirstName + ' ' + capitalizedLastName;
                        } else {
                            // For sorting and filtering, return the concatenated data
                            return capitalizedFirstName + ' ' + capitalizedLastName;
                        }
                    },
                    name: 'customer_name',
                    orderable: true,
                    searchable: false,
                    width: '33%'
                },
                {
                    data: 'email',
                    name: 'email',
                    orderable: true,
                    searchable: true,
                    width: '33%'
                },
                {
                    data: 'order_count',
                    render: function(data, type, row) {
                        if (data) {
                            return data; // If 'order_count' exists, return it
                        } else {
                            return '0'; // Provide a default value or message when it's null
                        }
                    },

                    searchable: false,
                    orderable: true,
                    width: '20%'
                },
                {
                    data: 'total_order_amount',
                    render: function(data, type, row) {
                        if (type === 'display') {
                            if (data) {
                                return parseFloat(data).toFixed(2) // If 'order_count' exists, return it
                            } else {
                                return '0.00'; // Provide a default value or message when it's null
                            }
                        } else {
                            return data; // For sorting and other types, return the original data
                        }
                    },

                    orderable: true,
                    searchable: false,
                    width: '20%'
                },
                {
                    data: 'reward_point_value',
                    render: function(data, type, row) {
                        if (data) {
                            return data; // If 'rewardpointsgift.reward_point_value' exists, return it
                        } else {
                            return '0'; // Provide a default value or message when it's null
                        }
                    }
                },
            ],
            columnDefs: [
            {
                className: 'text-right', // Apply 'text-right' class to the 'total_order_amount' column
                targets: [3,4,5] // Column class to target
            }
        ]
        });
    </script>
@endpush
