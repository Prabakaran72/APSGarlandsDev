@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('rewardpointsgift::customerrewardpoints.title'))
    <li class="active">{{ trans('rewardpointsgift::customerrewardpoints.title') }}</li>
@endcomponent

@component('admin::components.page.index_table')
    @slot('resource', 'customerrewardpoints')
    @slot('no_delete_btn', true)
    @slot('name', trans('rewardpointsgift::customerrewardpoints.customerrewardpoint'))

    @component('admin::components.table')
        @slot('thead')
            <tr>
                <th>{{ trans('admin::admin.table.id') }}</th>
                <th>{{ trans('rewardpointsgift::customerrewardpoints.table.customer_name') }}</th>
                <th>{{ trans('rewardpointsgift::customerrewardpoints.table.email') }}</th>
                <th>{{ trans('rewardpointsgift::customerrewardpoints.table.reward_points_earned_total') }}</th>
                <th>{{ trans('rewardpointsgift::customerrewardpoints.table.reward_points_claimed_total') }}</th>
                <th>{{ trans('rewardpointsgift::customerrewardpoints.table.in_live_earned_rewardpoints') }}</th>
                <th>{{ trans('rewardpointsgift::customerrewardpoints.table.expired_points') }}</th>
            </tr>
        @endslot
    @endcomponent
@endcomponent


@push('scripts')
    <script>
        new DataTable('#customerrewardpoints-table .table', {
            columns: [
                { data: 'id', name:'id', orderable: true,searchable: false, width: '5%'},
                { data: null, // Use null as the data source since we're not directly binding to a single attribute
                    render: function (data, type, row) {
                        // return row;
                        const capitalizedFirstName = row.user.first_name.charAt(0).toUpperCase() + row.user.first_name.slice(1);
                        const capitalizedLastName = row.user.last_name.charAt(0).toUpperCase() + row.user.last_name.slice(1);
                        if (type === 'display') {
                            // Concatenate first_name and last_name attributes
                            return capitalizedFirstName + ' ' + capitalizedLastName;
                        } else {
                            // For sorting and filtering, return the concatenated data
                            return capitalizedFirstName + ' ' + capitalizedLastName;
                        }
                    },
                    name: 'customer_name', orderable: true,searchable: false, width: '25%'} ,              
                { data: 'user.email', name: 'email',orderable: false,searchable: true, width: '25%' },                  
                { data: 'reward_points_earned_total', name: 'reward_points_earned_total', searchable: false, orderable: true, width: '15%' },
                { data: 'reward_points_claimed_total', name: 'reward_points_claimed_total', orderable: true,searchable: false, width: '15%' },
                { data: null,
                    render: function(row){
                        return row.reward_points_earned_total - row.reward_points_claimed_total-row.expired_points;
                    },
                    name:'in_live',orderable: true,searchable: false, width: '15%'},
                { data: 'expired_points', name: 'expired_points', orderable: true,searchable: false, width: '10%' },
            ],
        });
    </script>
@endpush
