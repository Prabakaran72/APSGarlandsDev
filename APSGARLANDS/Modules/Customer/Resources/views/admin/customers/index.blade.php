@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('customer::customers.customers'))

    <li class="active">{{ trans('customer::customers.customers') }}</li>
@endcomponent

@component('admin::components.page.index_table')
    @slot('resource', 'customers')
    @slot('buttons', ['create'])
    @slot('name', trans('customer::customers.customers'))

    @slot('thead')
        <tr>
            @include('admin::partials.table.select_all')

            <th>{{ trans('admin::admin.table.id') }}</th>
            <th>{{ trans('customer::customers.table.first_name') }}</th>
            <th>{{ trans('customer::customers.table.last_name') }}</th>
            <th>{{ trans('customer::customers.table.phone') }}</th>
            <th>{{ trans('customer::customers.table.email') }}</th>
            <th>{{ trans('customer::customers.table.address_1') }}</th>
            <th>{{ trans('customer::customers.table.zipcode') }}</th>
            <th>{{ trans('admin::admin.table.status') }}</th>
            <th data-sort>{{ trans('admin::admin.table.created') }}</th>
        </tr>
    @endslot
@endcomponent

@push('scripts')
    <script>
        var table = new DataTable('#customers-table .table', {
            columns: [
                { data: 'checkbox', orderable: false, searchable: false, width: '3%' },
                { data: 'id', width: '5%' },
                { data: 'first_name', name: 'customers.first_name', orderable: false, defaultContent: '' },
                { data: 'last_name', name: 'customers.last_name', orderable: false, defaultContent: '' },
                { data: 'phone', name: 'customers.phone', orderable: false, defaultContent: '' },
                { data: 'email', name: 'customers.email', orderable: false, defaultContent: '' },
                { data: 'address_1', name: 'customers.address_1', orderable: false, defaultContent: '' },
                { data: 'zip', name: 'customers.zip', orderable: false, defaultContent: '' },
                { data: 'status', name: 'is_active', searchable: false },
                { data: 'created', name: 'created_at' },
            ],
        });
        
    </script>
@endpush
