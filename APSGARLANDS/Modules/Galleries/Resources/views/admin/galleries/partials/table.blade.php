<div class="box-body index-table" id="galleries-table">
    @component('admin::components.table')
        @slot('thead')
            <tr>
                @include('admin::partials.table.select_all')

                <th data-sort>{{ trans('admin::admin.table.id') }}</th>
                <th>{{ trans('galleries::galleries.table.videoID') }}</th>
                <th>{{ trans('galleries::galleries.table.videoTitle') }}</th>
                <th>{{ trans('galleries::galleries.table.channelTitle') }}</th>
                <th data-sort>{{ trans('admin::admin.table.created') }}</th>

                @unless (request()->routeIs('admin.galleries.index'))
                    <th class="min-tablet"></th>
                @endif
            </tr>
        @endslot
    @endcomponent
</div>
