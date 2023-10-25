<?php

namespace Modules\RewardpointsGift\Admin;

use Modules\Admin\Ui\AdminTable;

class CustomerRewardPointsTable extends AdminTable
{
    /**
     * Make table response for the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function make()
    {
        return $this->newTable()
            ->addColumn('customer_name', function ($customerRewardPoints) {
                return $customerRewardPoints->customer_name;
            })
            ->addColumn('id', function ($customerRewardPoints) {
                return $customerRewardPoints->user->id;
            });
            // ->editColumn('total', function ($order) {
            //     return $order->total->format();
            // })
            // ->editColumn('status', function ($order) {
            //     return $order->status();
            // });
    }
}
