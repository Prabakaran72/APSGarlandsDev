@extends('public.account.layout')

@section('title', trans('storefront::account.pages.my_rewardpoints'))

@section('account_breadcrumb')
    <li class="active">{{ trans('storefront::account.pages.my_rewardpoints') }}</li>
@endsection

@section('panel')
    <div class="panel">
        <div class="panel-header">
            <h4>{{ trans('storefront::account.pages.my_rewardpoints') }}</h4>
        </div>

        <div class="panel-body">
            @if ($rewardpoints->isEmpty())
                <div class="empty-message">
                    <h3>{{ trans('storefront::account.rewardpoints.no_rewardpoints') }}</h3>
                </div>
            @else
                <div class="table-responsive">
                    <table class="table table-borderless my-rewardpoints-table">
                        <thead>
                            <tr>
                                <th>{{ trans('storefront::account.rewardpoints.reward_type') }}</th>
                                <th>{{ trans('storefront::account.rewardpoints.created_at') }}</th>
                                <th>{{ trans('storefront::account.rewardpoints.reward_points_earned') }}</th>
                                <th>{{ trans('storefront::account.rewardpoints.reward_points_claimed') }}</th>
                                <th>{{ trans('storefront::account.rewardpoints.expiry_date') }}</th>
                            </tr>
                        </thead>

                        <tbody>
                            @php
                                //Initialized for calculation
                                $totalPointEarned = 0;
                                $totalPointsClaimed = 0;
                                $totalPointsExpired = 0;
                                $totalPointsUsedExpired =0;
                                $totalPointsEarnedExpired =0;
                                $alivePoints = 0;
                                $currentDate = date("Y-m-d H:i:s");
                            @endphp

                            @foreach ($rewardpoints as $row)
                                <tr>
                                    <td>
                                        @if ($row->reward_type)
                                            {{ trans('storefront::account.rewardpoints.reward_types.' . $row->reward_type) }}
                                        @else
                                            {{ 'Claimed' }}
                                        @endif
                                    </td>
                                    <td>{{ $row->created_at }}</td>
                                    <td>{{ $row->reward_points_earned ? $row->reward_points_earned : '-' }}</td>
                                    <td>{{ $row->reward_points_claimed ? $row->reward_points_claimed : '-' }}</td>
                                    <td>{{ $row->expiry_date }}</td>

                                </tr>
                                @php
                                    $totalPointEarned += $row->reward_points_earned ? $row->reward_points_earned : 0;
                                    $totalPointsClaimed += $row->reward_points_claimed ? $row->reward_points_claimed : 0;
                                    if(!is_null($row->expiry_date))
                                    {
                                        $totalPointsEarnedExpired = 'expirydate not null \n\r';
                                    }
                                    if($row->expiry_date < $currentDate)
                                    {
                                        $totalPointsEarnedExpired = 'expirydate less than current \n\r';
                                    }
                                    if($row->created_at < $currentDate)
                                    {
                                        $totalPointsEarnedExpired = 'createdate less than current \n\r';
                                    }
                                    if(!is_null($row->reward_points_claimed))
                                    {
                                        $totalPointsEarnedExpired = 'reward_points_claimed is null \n\r';
                                    }

                                    if(!is_null($row->expiry_date) && $row->expiry_date < $currentDate && $row->created_at < 
                                    $currentDate && !is_null($row->reward_points_claimed))
                                    {
                                        $totalPointsUsedExpired += $row->reward_points_claimed;
                                    }
                                    if(is_null($row->expiry_date) && $row->expiry_date < $currentDate && !is_null($row->reward_points_earned))
                                    {
                                        $totalPointsEarnedExpired +=$row->reward_points_earned;
                                    }
                                @endphp
                            @endforeach
                        </tbody>
                        <tfoot>
                            <tr>
                                <th colspan="5">
                                    {{ trans('storefront::account.rewardpoints.totalPointEarned') }}
                                    {{ $totalPointEarned }}<br>
                                    {{ trans('storefront::account.rewardpoints.totalPointsClaimed') }}
                                    {{ $totalPointsClaimed }}<br>
                                    {{-- {{ trans('storefront::account.rewardpoints.alive_points') }}:
                                    {{ $rewardPointTotals['totalPointsAliveAndNotClaimed'] }} --}}
                                    {{ 'totalPointsEarnedExpired'}}:
                                    {{ $totalPointsEarnedExpired}}
                                    {{ 'totalPointsUsedExpired' }}:
                                    {{ $totalPointsUsedExpired }}
                                </th>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            @endif
        </div>

        <div class="panel-footer">
            {!! $rewardpoints->links() !!}
        </div>
    </div>
@endsection
