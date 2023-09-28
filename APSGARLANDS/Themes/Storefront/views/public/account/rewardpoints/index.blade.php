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
                    @php
                        function calculateRewardPoints($rewardpoints)
                        {
                            $currentDate = now(); // Get the current date and time
                            $totalPointEarned = 0;
                            $totalPointsClaimed = 0;
                            $totalPointsExpiredAndNotClaimed = 0;
                            $totalPointsAliveAndNotClaimed = 0;
                        
                            foreach ($rewardpoints as $row) {
                                if ($row->reward_points_earned) {
                                    $totalPointEarned += $row->reward_points_earned;
                                }
                        
                                if ($row->reward_points_claimed) {
                                    $totalPointsClaimed += $row->reward_points_claimed;
                                }
                        
                                if ($row->expiry_date) {
                                    $expiryDate = \Carbon\Carbon::parse($row->expiry_date);
                                    if ($expiryDate->lt($currentDate) && !$row->reward_points_claimed) {
                                        $totalPointsExpiredAndNotClaimed += $row->reward_points_earned ?? 0;
                                    } elseif ($expiryDate->gte($currentDate) && !$row->reward_points_claimed) {
                                        $totalPointsAliveAndNotClaimed += $row->reward_points_earned ?? 0;
                                    }
                                }
                            }
                        
                            return [
                                'totalPointEarned' => $totalPointEarned,
                                'totalPointsClaimed' => $totalPointsClaimed,
                                'totalPointsExpiredAndNotClaimed' => $totalPointsExpiredAndNotClaimed,
                                'totalPointsAliveAndNotClaimed' => $totalPointsAliveAndNotClaimed,
                            ];
                        }
                        
                        $rewardPointTotals = calculateRewardPoints($rewardpoints);
                    @endphp

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
                            @foreach ($rewardpoints as $row)
                                <tr>
                                    <td>
                                        @if ($row->reward_type)
                                            {{ trans('storefront::account.rewardpoints.reward_types.' . $row->reward_type) }}
                                        @else
                                            Claimed
                                        @endif
                                    </td>
                                    <td>{{ $row->created_at }}</td>
                                    <td>{{ $row->reward_points_earned ? $row->reward_points_earned : '-' }}</td>
                                    <td>{{ $row->reward_points_claimed ? $row->reward_points_claimed : '-' }}</td>
                                    <td>{{ $row->expiry_date }}</td>

                                </tr>
                            @endforeach
                        </tbody>
                        <tfoot>
                            <tr>
                                <th colspan="5">
                                    {{ trans('storefront::account.rewardpoints.totalPointEarned') }}:
                                    {{ $rewardPointTotals['totalPointEarned'] }}<br>
                                    {{ trans('storefront::account.rewardpoints.totalPointsClaimed') }}:
                                    {{ $rewardPointTotals['totalPointsClaimed'] }}<br>
                                    {{ trans('storefront::account.rewardpoints.alive_points') }}:
                                    {{ $rewardPointTotals['totalPointsAliveAndNotClaimed'] }}
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
