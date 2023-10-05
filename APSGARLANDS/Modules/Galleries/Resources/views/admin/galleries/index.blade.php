@extends('admin::layout')

@component('admin::components.page.header')
    @slot('title', trans('galleries::galleries.galleries'))

    <li class="active">{{ trans('galleries::galleries.galleries') }}</li>
@endcomponent
@component('admin::components.page.index_table')
    {{--@slot('buttons', ['create']) --}}
    @slot('resource', 'galleries')
    @slot('name', trans('galleries::galleries.galleries'))

    @slot('thead')
        @include('galleries::admin.galleries.partials.thead', ['name' => 'galleries-index'])
    @endslot
@endcomponent
@push('scripts')
    <script>
        DataTable.setRoutes('#galleries-table .table', {
            index: 'admin.galleries.index',
            destroy: 'admin.galleries.destroy',
        });

        new DataTable('#galleries-table .table', {
            columns: [
                { data: 'checkbox', orderable: false, searchable: false, width: '3%' },
                { data: 'id', width: '5%' },
                { data: 'videoID', orderable: false, searchable: false, width: '10%' },
                { data: 'videoTitle', orderable: false, searchable: false, width: '10%' },
                { data: 'channelTitle', orderable: false, searchable: false, width: '10%' },
                { data: 'created', name: 'created_at' },
            ],
        });
    </script>
@endpush
