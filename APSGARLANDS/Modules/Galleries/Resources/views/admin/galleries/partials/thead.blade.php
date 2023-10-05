<tr>
    @include('admin::partials.table.select_all')

    <th>{{ trans('admin::admin.table.id') }}</th>
    <th>{{ trans('galleries::galleries.table.videoID') }}</th>
    <th>{{ trans('galleries::galleries.table.videoTitle') }}</th>
    <th>{{ trans('galleries::galleries.table.channelTitle') }}</th>
    <th data-sort>{{ trans('admin::admin.table.created') }}</th>
</tr>
