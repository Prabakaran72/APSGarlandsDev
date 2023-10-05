@include('admin::partials.selectize_remote')

@push('shortcuts')
    <dl class="dl-horizontal">
        <dt><code>b</code></dt>
        <dd>{{ trans('admin::admin.shortcuts.back_to_index', ['name' => trans('rewardpoints::rewardpoints.rewardpoints')]) }}</dd>
    </dl>
@endpush

@push('scripts')
    <script>
        keypressAction([
            { key: 'b', route: "{{ route('admin.rewardpoints.index') }}" },
        ]);
    </script>
@endpush
