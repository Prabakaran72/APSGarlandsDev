@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('blogcategory::blogcategorys.blogcategory'))

    <li class="active">{{ trans('blogcategory::blogcategorys.blogcategory') }}</li>
@endcomponent

@component('admin::components.page.index_table')
    @slot('resource', 'blogcategorys')
    @slot('buttons', ['create'])
    @slot('name', trans('blogcategory::blogcategorys.blogcategory'))

    @slot('thead')
        <tr>
            @include('admin::partials.table.select_all')

            <th>{{ trans('admin::admin.table.id') }}</th>
            <th>{{ trans('blogcategory::attributes.category_name') }}</th>
            <th>{{ trans('blogcategory::attributes.category_code') }}</th>
            <th>{{ trans('blogcategory::attributes.description') }}</th>

            <th data-sort>{{ trans('admin::admin.table.created') }}</th>
        </tr>
    @endslot
@endcomponent

@push('scripts')
    <script>
        new DataTable('#blogcategorys-table .table', {
            columns: [
                { data: 'checkbox', orderable: false, searchable: false, width: '3%' },
                { data: 'id', width: '5%' },
                { data: 'category_name', name: 'category_name', orderable: false, defaultContent: '' },
                { data: 'category_code', name: 'category_code', searchable: false },
                { data: 'description', name: 'description', searchable: false },
                { data: 'created', name: 'created_at' },
            ],
        });
    </script>
@endpush
