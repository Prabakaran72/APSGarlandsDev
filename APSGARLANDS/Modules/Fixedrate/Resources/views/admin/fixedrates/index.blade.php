@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('fixedrate::fixedrates.fixedrates'))

    <li class="active">{{ trans('fixedrate::fixedrates.fixedrates') }}</li>
@endcomponent

@component('admin::components.page.index_table')
    @slot('resource', 'fixedrates')
    @slot('buttons', ['create'])
    @slot('name', trans('fixedrate::fixedrates.fixedrate'))
    @slot('flat_price', trans('fixedrate::fixedrates.fixedrate'))

    @slot('thead')
        <tr>
            @include('admin::partials.table.select_all')

            <th>{{ trans('admin::admin.table.id') }}</th>
            <th>{{ trans('fixedrate::fixedrates.table.name') }}</th>
            <th>{{ trans('fixedrate::fixedrates.table.flat_price') }}</th>
            <th>{{ trans('admin::admin.table.status') }}</th>
            <th data-sort>{{ trans('admin::admin.table.created') }}</th>
        </tr>
    @endslot
@endcomponent

@push('scripts')
    <script>
        new DataTable('#fixedrates-table .table', {
            columns: [
                { data: 'checkbox', orderable: false, searchable: false, width: '3%' },
                { data: 'id', width: '5%' },
                { data: 'pincode', name: 'translations.name', orderable: false, defaultContent: '' },
                { data: 'flat_price', name: 'translations.name', orderable: false, defaultContent: '' },
                { data: 'status', name: 'is_active', searchable: false },
                { data: 'created', name: 'created_at' },
            ],
        });
    </script>
@endpush
