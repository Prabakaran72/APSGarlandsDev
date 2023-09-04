@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('testimonial::testimonials.testimonials'))

    <li class="active">{{ trans('testimonial::testimonials.testimonials') }}</li>
@endcomponent

@component('admin::components.page.index_table')
    {{-- @slot('buttons', ['create']) --}}
    @slot('resource', 'testimonials')
    @slot('name', trans('testimonial::testimonials.testimonial'))

    @slot('thead')
        <tr>
            @include('admin::partials.table.select_all')
            <th data-sort>{{ trans('admin::admin.table.id') }}</th>
            <th>{{ trans('testimonial::testimonials.table.discount') }}</th>
            <th>{{ trans('testimonial::testimonials.table.name') }}</th>
            <th>{{ trans('testimonial::testimonials.table.comment') }}</th>
            <th>{{ trans('admin::admin.table.status') }}</th>
            <th data-sort>{{ trans('admin::admin.table.created') }}</th>
        </tr>
    @endslot
@endcomponent

@push('scripts')
    <script>
        new DataTable('#testimonials-table .table', {
            columns: [
                { data: 'checkbox', orderable: false, searchable: false, width: '3%' },
                { data: 'id', width: '5%' },
                { data: 'user_id' },
                // { data: 'name', name: 'translations.name', orderable: false, defaultContent: '' },
                { data: 'user_name' },
                { data: 'comment' },
                { data: 'status', name: 'is_active', searchable: false },
                { data: 'created', name: 'created_at' },
            ],
        });
    </script>
@endpush
