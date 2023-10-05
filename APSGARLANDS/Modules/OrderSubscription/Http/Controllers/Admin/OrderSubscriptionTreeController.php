<?php

namespace Modules\OrderSubscription\Http\Controllers\Admin;

use Modules\OrderSubscription\Entities\OrderSubscription;
use Modules\OrderSubscription\Services\OrderSubscriptionTreeUpdater;
use Modules\OrderSubscription\Http\Responses\OrderSubscriptionTreeResponse;

class OrderSubscriptionTreeController
{
    /**
     * Display ordersubscription tree in json.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $ordersubscriptions = OrderSubscription::withoutGlobalScope('active')
            ->orderByRaw('-position DESC')
            ->get();

        return new OrderSubscriptionTreeResponse($ordersubscriptions);
    }

    /**
     * Update ordersubscription tree in storage.
     *
     * @return \Illuminate\Http\Response
     */
    public function update()
    {
        OrderSubscriptionTreeUpdater::update(request('ordersubscription_tree'));

        return trans('ordersubscription::messages.ordersubscription_order_saved');
    }
}
