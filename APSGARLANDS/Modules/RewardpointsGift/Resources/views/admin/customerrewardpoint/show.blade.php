@extends('admin::layout')

@component('admin::components.page.header_customer_reward')
    @slot('title', (trans('rewardpointsgift::customerrewardpoints.customerrewardpoints')))
    @slot('customername', ($customer->full_name))
    <li class="pointer"><a href="{{ route('admin.customerrewardpoints.index') }}">{{ trans('rewardpointsgift::customerrewardpoints.title') }}</a></li>    
    <li class="active">{{ trans('rewardpointsgift::customerrewardpoints.customerrewardpoints') }}</li>    
@endcomponent

@component('admin::components.page.header')
    @slot('title', trans('rewardpointsgift::customerrewardpoints.customerrewardpoints'))
@endcomponent

@component('admin::components.page.index_table')

    @slot('resource', 'customerrewardpoints')
    @slot('name', trans('rewardpointsgift::customerrewardpoints.customerrewardpoint'))

    @component('admin::components.table')
        @slot('thead')
            <tr>
                <th class="text-center">{{ trans('admin::admin.table.id') }}</th>
                <th class="text-center">{{ trans('rewardpointsgift::customerrewardpoints.table.created_at') }}</th>
                <th class="text-center">{{ trans('rewardpointsgift::customerrewardpoints.table.reward_type') }}</th>
                <th  class="text-center">{{ trans('rewardpointsgift::customerrewardpoints.table.earned_reward_points') }}</th>
                <th  class="text-center">{{ trans('rewardpointsgift::customerrewardpoints.table.claimed_reward_points') }}</th>
                <th  class="text-center">{{ trans('rewardpointsgift::customerrewardpoints.table.expiry_date') }}</th>
            </tr>
            @endslot
            @php 
            $i = 1; 
            @endphp
           @foreach ($customerrewardpoint as $row)
                    <tr>
                        <td class="text-center">{{ $i++ }}</td>
                        <td class="text-center">{{ $row->created_at }}</td>
                        <td class="text-center">{{ !empty($row->reward_type) ? trans ("rewardpointsgift::customerrewardpoints.rewardtype.".$row->reward_type) : '-'}}</td>
                        <td class="text-center">{{ $row->reward_points_earned ?? 0}}</td>
                        <td class="text-center">{{ $row->reward_points_claimed ?? 0 }}</td>
                        <td class="text-center">{{ $row->expiry_date ?? "-"}}</td>
                    </tr>    
                    @endforeach
    @endcomponent
@endcomponent

