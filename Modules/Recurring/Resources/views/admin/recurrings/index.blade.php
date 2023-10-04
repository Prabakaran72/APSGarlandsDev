@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('recurring::recurrings.recurrings'))

    <li class="active">{{ trans('recurring::recurrings.recurrings') }}</li>
@endcomponent

@component('admin::components.page.index_table')
    @slot('resource', 'recurrings')
    @slot('name', trans('recurring::recurrings.recurring'))

    @slot('thead')
        <tr>
            @include('admin::partials.table.select_all')
            <th>{{ trans('recurring::recurrings.table.recurring_order_main_id') }}</th>
            <th>{{ trans('recurring::recurrings.table.customer_name') }}</th>
            <th>{{ trans('recurring::recurrings.table.customer_email') }}</th>
            <th>{{ trans('recurring::recurrings.table.delivery_time') }}</th>
            <th data-sort>{{ trans('admin::admin.table.created') }}</th>
        </tr>
    @endslot
@endcomponent


@push('scripts')
    <script>
        // DataTable.setRoutes('#recurrings-table .table', {
        //     index: '{{ 'admin.recurrings.index' }}',
        //     edit: '{{ 'admin.recurringSubOrder.index' }}',
        // });

        new DataTable('#recurrings-table .table', {
            columns: [{
                    data: 'checkbox',
                    orderable: false,
                    searchable: false,
                    width: '3%'
                },
                {
                    data: 'id'
                },

                {
                    data: null, // Use null as the data source since we're not directly binding to a single attribute
                    render: function(data, type, row) {
                        // return row;

                        const capitalizedFirstName = row.user.first_name.charAt(0).toUpperCase() + row.user
                            .first_name.slice(1);
                        const capitalizedLastName = row.user.last_name.charAt(0).toUpperCase() + row.user
                            .last_name.slice(1);
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
                    width: '25%'
                },


                {
                    data: 'user.email'
                },
                {
                    data: 'delivery_time',
                    render: function(data) {
                        // Assuming 'data' is in the format 'HH:MM:SS'
                        var timeParts = data.split(':');
                        return timeParts[0] + ':' + timeParts[1];
                    }
                },

                {
                    data: 'created',
                    name: 'created_at'
                },
            ],
        });
    </script>
@endpush
