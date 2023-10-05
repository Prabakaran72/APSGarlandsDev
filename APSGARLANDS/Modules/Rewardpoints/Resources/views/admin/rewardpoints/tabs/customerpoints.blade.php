<div class="box-body index-table" id="customer_rewardpoints-table">
    @component('admin::components.table', ['id' => 'customer_rewardpoints-table'])
        @slot('buttons', ['create'])
        @slot('resource', 'rewardpoints')
        @slot('name', trans('rewardpoints::rewardpoints.rewardpoint'))

        @slot('thead')
            <tr>
                {{-- @include('admin::partials.table.select_all') --}}

                <th>{{ trans('admin::admin.table.id') }}</th>
                <th>{{ trans('rewardpoints::rewardpoints.table.customer_email') }}</th>
                <th>{{ trans('rewardpoints::rewardpoints.table.no_of_orders') }}</th>
                <th>{{ trans('rewardpoints::rewardpoints.table.total_order_amount') }}</th>
                <th>{{ trans('rewardpoints::rewardpoints.table.total_reward_points') }}</th>
                <th>{{ trans('rewardpoints::rewardpoints.table.total_reward_amount') }}</th>
                {{-- <th>{{ trans('rewardpoints::rewardpoints.table.add_reward') }}</th> --}}
            </tr>
        @endslot
    @endcomponent
</div>

@push('scripts')
    <script>
    
        new DataTable('#customer_rewardpoints-table .table', {

            columns: [
                // { data: 'checkbox', orderable: false, searchable: false, width: '3%' },
                {
                    data: 'id',
                    width: '5%'
                },
                {
                    data: 'email',
                    name: 'email'
                },
                {
                    data: 'order_count',
                    name: 'order_count'
                },
                {
                    data: 'order_total',
                    name: 'order_total'
                },
                {
                    data: 'total_rewardpoints',
                    name: 'total_rewardpoints'
                },
                {
                    data: 'total_amount',
                    name: 'total_amount'
                },
                // { data: 'total_amount', name: 'total_amount'},
            ]
        });
    </script>
@endpush
