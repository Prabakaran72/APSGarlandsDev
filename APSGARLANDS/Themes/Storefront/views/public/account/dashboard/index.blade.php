@extends('public.account.layout')

@section('title', trans('storefront::account.pages.dashboard'))

@section('panel')
    @if ($recentOrders->isNotEmpty())
        <div class="panel">
            <div class="panel-header">
                <h4>{{ trans('storefront::account.dashboard.recent_orders') }}</h4>

                <a href="{{ route('account.orders.index') }}">
                    {{ trans('storefront::account.dashboard.view_all') }}
                </a>
            </div>

            <div class="panel-body">
                @include('public.account.partials.orders_table', ['orders' => $recentOrders])
            </div>
        </div>
    @endif

    <div class="panel">
        <div class="panel-header">
            <h4>{{ trans('storefront::account.dashboard.account_information') }}</h4>

            <a href="{{ route('account.profile.edit') }}">
                {{ trans('storefront::account.dashboard.edit') }}
            </a>
        </div>

        <div class="panel-body">
            <ul class="list-inline user-info">
                <li>
                @if ($account->sso_google=='1' || $account->sso_fb=='1' )
               <img src="{{ $account->sso_avatar }}" class="  profile-image"></img>
               @elseif($account->sso_fb=='' && $account->sso_google=='' && (!empty($account->image_url)))
               <img src="{{ $account->image_url }}" class=" profile-image"></img>
               @else 
               <i class="las la-user-circle"></i>
                @endif
                    <span>{{ $account->full_name }}</span>
                </li>

                <li>
                    <i class="las la-envelope"></i>
                    <span>{{ $account->email }}</span>
                </li>
            </ul>
        </div>
    </div>
@endsection
