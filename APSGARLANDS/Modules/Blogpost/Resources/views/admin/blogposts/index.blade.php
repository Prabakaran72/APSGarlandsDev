@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('blogpost::blogposts.blogpost'))

    <li class="active">{{ trans('blogpost::blogposts.blogpost') }}</li>
@endcomponent

@component('admin::components.page.index_table')
    @slot('resource', 'blogposts')
    @slot('buttons', ['create'])
    @slot('name', trans('blogpost::blogposts.blogpost'))

    @slot('thead')
        <tr>
            @include('admin::partials.table.select_all')

            <th>{{ trans('admin::admin.table.id') }}</th>
            <th>{{ trans('blogpost::attributes.category_id') }}</th>
            <th>{{ trans('blogpost::attributes.tag_id') }}</th>
            <th>{{ trans('blogpost::attributes.post_title') }}</th>
            <th>{{ trans('blogpost::attributes.author_id') }}</th>
            <th>{{ trans('blogpost::attributes.post_status') }}</th>
            <th data-sort>{{ trans('admin::admin.table.created') }}</th>
        </tr>
    @endslot
@endcomponent

@push('scripts')
    <script>
        new DataTable('#blogposts-table .table', {
            columns: [
                { data: 'checkbox', orderable: false, searchable: false, width: '3%' },
                { data: 'id', width: '5%' },
                { data: 'category.category_name', name: 'category_name', orderable: false, defaultContent: '' },
                { data: 'tag.tag_name', name: 'tag_name', orderable: false, defaultContent: '' },
                { data: 'post_title', name: 'post_title', searchable: false },
                { data: 'users.first_name', name: 'first_name', orderable: false, defaultContent: '' },
                { data: 'post_status', name: 'post_status', searchable: false },
                { data: 'created', name: 'created_at' },
            ],
        });
    </script>
@endpush
