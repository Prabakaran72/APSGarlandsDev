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
            {{-- <th>{{ trans('recurring::recurrings.table.main_order_id') }}</th> --}}
            <th>{{ trans('recurring::recurrings.table.delivery_time') }}</th>
            {{-- <th>{{ trans('recurring::recurrings.table.completed_status') }}</th> --}}
            <th data-sort>{{ trans('admin::admin.table.created') }}</th>
        </tr>
    @endslot
@endcomponent

@push('scripts')
    <script>

        new DataTable('#recurrings-table .table', {
            columns: [
                { data: 'checkbox', orderable: false, searchable: false, width: '3%' },
                { data: 'id' },
                { data: 'first_name', name: 'customers.first_name', orderable: false, defaultContent: '' },
                  { data: 'id' }, //customer_email
                { data: 'delivery_time' }, //delivery_time
                // { data: 'status', name: 'is_active', searchable: false },
                { data: 'created', name: 'created_at' },
            ],
        });
    </script>
@endpush
