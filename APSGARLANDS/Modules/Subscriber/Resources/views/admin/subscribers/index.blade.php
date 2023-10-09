@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('subscriber::subscribers.subscribers'))

    <li class="active">{{ trans('subscriber::subscribers.subscribers') }}</li>
@endcomponent

@component('admin::components.page.index_table')
    @slot('resource', 'subscribers')
    {{-- @slot('buttons', ['create']) --}}
    @slot('name', trans('subscriber::subscribers.subscriber'))

    @slot('thead')
        <tr>
            @include('admin::partials.table.select_all')
            <th>{{ trans('admin::admin.table.id') }}</th>
            <th>{{ trans('subscriber::subscribers.table.email') }}</th>
            {{-- <th>{{ trans('admin::admin.table.status') }}</th> --}}
            <th data-sort>{{ trans('admin::admin.table.created') }}</th>
        </tr>
    @endslot
@endcomponent

@push('scripts')
    <script>
        DataTable.setRoutes('#subscribers-table .table', {
            index: 'admin.subscribers.index',
            destroy: 'admin.subscribers.destroy',
        });											
				
        new DataTable('#subscribers-table .table', {
            columns: [
                { data: 'checkbox', orderable: false, searchable: false, width: '3%' },
                { data: 'id', width: '5%' },
                { data: 'email', name: 'translations.name', orderable: false, defaultContent: '' },
                // { data: 'status', name: 'is_active', searchable: false },
                { data: 'created', name: 'created_at' },
            ],
        });
    </script>
@endpush
