<?php

namespace Modules\RewardpointsGift\Admin;

use Modules\Admin\Ui\AdminTable;

class RewardpointsCustomerTable extends AdminTable
{
    /**
     * Make table response for the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function make()
    {
        // return $this->newTable()
        //     ->addColumn('customer_name', function ($rewardpointsGift) {
        //         return $rewardpointsGift->customer_name;
        //     });
            // ->editColumn('total', function ($order) {
            //     return $order->total->format();
            // })
            // ->editColumn('status', function ($order) {
            //     return $order->status();
            // });
    }
}
