@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('email::emails.emails'))

    <li class="active">{{ trans('email::emails.emails') }}</li>
@endcomponent

@component('admin::components.page.index_table')
    @slot('resource', 'emails')
    @slot('buttons', ['create'])
    @slot('name', trans('email::emails.email'))

    @slot('thead')
        <tr>
            @include('admin::partials.table.select_all')

            <th>{{ trans('admin::admin.table.id') }}</th>
            <th>{{ trans('email::emails.table.subject') }}</th>
            <th>{{ trans('admin::admin.table.status') }}</th>
            <th data-sort>{{ trans('admin::admin.table.created') }}</th>
        </tr>
    @endslot
@endcomponent

@push('scripts')
    <script>
        new DataTable('#emails-table .table', {
            columns: [
                { data: 'checkbox', orderable: false, searchable: false, width: '3%' },
                { data: 'id', width: '5%' },
                { data: 'subject', name: 'translations.subject', orderable: false, defaultContent: '' },
                { data: 'status', name: 'is_active', searchable: false },
                { data: 'created', name: 'created_at' },
            ],
        });
    </script>
@endpush
