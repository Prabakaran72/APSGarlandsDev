@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('rewardpoints::rewardpoints.rewardpoints'))

    <li class="active">{{ trans('rewardpoints::rewardpoints.rewardpoints') }}</li>
@endcomponent

@component('admin::components.page.index_table')
    @slot('buttons', ['create'])
    @slot('resource', 'rewardpoints')
    @slot('name', trans('rewardpoints::rewardpoints.rewardpoints'))

    @slot('thead')
        <tr>
            {{-- @include('admin::partials.table.select_all') --}}

            {{-- <th data-sort>{{ trans('admin::admin.table.id') }}</th>
            <th>{{ trans('rewardpoints::rewardpoints.table.name') }}</th>
            <th>{{ trans('rewardpoints::rewardpoints.table.code') }}</th>
            <th>{{ trans('rewardpoints::rewardpoints.table.discount') }}</th>
            <th>{{ trans('admin::admin.table.status') }}</th>
            <th data-sort>{{ trans('admin::admin.table.created') }}</th> --}}

                <th>{{ trans('admin::admin.table.id') }}</th>
                <th>{{ trans('rewardpoints::rewardpoints.table.customer_email') }}</th>
                <th>{{ trans('rewardpoints::rewardpoints.table.no_of_orders') }}</th>
                <th>{{ trans('rewardpoints::rewardpoints.table.total_order_amount') }}</th>
                <th>{{ trans('rewardpoints::rewardpoints.table.total_reward_points') }}</th>
                <th>{{ trans('rewardpoints::rewardpoints.table.total_reward_amount') }}</th>
        </tr>
    @endslot
@endcomponent

@push('scripts')
    <script>
        new DataTable('#rewardpoints-table .table', {
            columns: [
                // { data: 'checkbox', orderable: false, searchable: false, width: '3%' },
                { data: 'id', width: '5%' },
                { data: 'redemption_point_value', name: 'redemption_point_value', orderable: true },
                { data: 'user_id', name: 'user_id', orderable: true },
                { data: 'user_id', name: 'user_id', orderable: true },
                { data: 'user_id', name: 'user_id', orderable: true },
                { data: 'user_id', name: 'user_id', orderable: true },
            ],
        });
    </script>
@endpush
