@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('blogtag::blogtags.blogtag'))

    <li class="active">{{ trans('blogtag::blogtags.blogtag') }}</li>
@endcomponent

@component('admin::components.page.index_table')
    @slot('resource', 'blogtags')
    @slot('buttons', ['create'])
    @slot('name', trans('blogtag::blogtags.blogtag'))

    @slot('thead')
        <tr>
            @include('admin::partials.table.select_all')

            <th>{{ trans('admin::admin.table.id') }}</th>
            <th>{{ trans('blogtag::attributes.tag_name') }}</th>
            <th>{{ trans('blogtag::attributes.tag_code') }}</th>
            <th>{{ trans('blogtag::attributes.description') }}</th>

            <th data-sort>{{ trans('admin::admin.table.created') }}</th>
        </tr>
    @endslot
@endcomponent

@push('scripts')
    <script>
        new DataTable('#blogtags-table .table', {
            columns: [
                { data: 'checkbox', orderable: false, searchable: false, width: '3%' },
                { data: 'id', width: '5%' },
                { data: 'tag_name', name: 'tag_name', orderable: false, defaultContent: '' },
                { data: 'tag_code', name: 'tag_code', searchable: false },
                { data: 'description', name: 'description', searchable: false },
                { data: 'created', name: 'created_at' },
            ],
        });
    </script>
@endpush
