@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('pickupstore::pickupstore.pickupstores'))

    <li class="active">{{ trans('pickupstore::pickupstore.pickupstores') }}</li>
@endcomponent

@component('admin::components.page.index_table')
    @slot('resource', 'pickupstores')
    @slot('buttons', ['create'])
    @slot('name', trans('pickupstore::pickupstore.pickupstore'))
    @slot('city', trans('pickupstore::pickupstore.pickupstore'))

    @slot('thead')
        <tr>
            @include('admin::partials.table.select_all')

            <th>{{ trans('admin::admin.table.id') }}</th>
            <th>{{ trans('pickupstore::pickupstore.table.first_name') }}</th>
            <th>{{ trans('pickupstore::pickupstore.table.city') }}</th>
            <th>{{ trans('admin::admin.table.status') }}</th>
            <th data-sort>{{ trans('admin::admin.table.created') }}</th>
        </tr>
    @endslot
@endcomponent

@push('scripts')
    <script>
        new DataTable('#pickupstores-table .table', {
            columns: [
                { data: 'checkbox', orderable: false, searchable: false, width: '3%' },
                { data: 'id', width: '5%' },
                { data: 'first_name', name: 'translations.first_name', orderable: false, defaultContent: '' },
                { data: 'city', name: 'city', searchable: false },
                { data: 'status', name: 'is_active', searchable: false },
                { data: 'created', name: 'created_at' },
            ],
        });
    </script>
@endpush
