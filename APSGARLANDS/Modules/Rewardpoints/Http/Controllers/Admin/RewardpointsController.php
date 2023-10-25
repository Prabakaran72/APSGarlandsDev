<?php

namespace Modules\Rewardpoints\Http\Controllers\Admin;

use Modules\Rewardpoints\Entities\Rewardpoints;
use Modules\Admin\Traits\HasCrudActions;
use Modules\Rewardpoints\Http\Requests\SaveRewardpointsRequest;
use Modules\Admin\Ui\Facades\TabManager;
use Illuminate\Http\Request;

class RewardpointsController
{
    use HasCrudActions;

    /**
     * Model for the resource.
     *
     * @var string
     */
    protected $model = Rewardpoints::class;

    /**
     * Label of the resource.
     *
     * @var string
     */
    protected $label = 'rewardpoints::rewardpoints.rewardpoints';

    /**
     * View path of the resource.
     *
     * @var string
     */
    protected $viewPath = 'rewardpoints::admin.rewardpoints';

    /**
     * Form requests for the resource.
     *
     * @var array|string
     */
    protected $validation = SaveRewardpointsRequest::class;



    /**
     * Show the form for editing the specified resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function edit()
    {

        $obj = new Rewardpoints;
        $rewardpoints = $obj->getRewardPointsSettings();

        $tabs = TabManager::get('rewardpoints');

        return view('rewardpoints::admin.rewardpoints.edit', compact('rewardpoints', 'tabs'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request)
    {
        $this->handleMaintenanceMode($request);
        // setting($request->except('_token', '_method'));
        $obj = Rewardpoints::find(1);
        // dd($request->except('_token', '_method'));


      $obj->enable_bday_points = $request->enable_bday_points ? 1 : 0;
      $obj->enable_give_old_order_points = $request->enable_give_old_order_points ? 1 : 0;
      $obj->enable_remove_points_order_refund = $request->enable_remove_points_order_refund ? 1 : 0;
      $obj->add_days_reward_points_expiry = $request->add_days_reward_points_expiry ?? 0;
      $obj->add_days_reward_points_assignment = $request->add_days_reward_points_assignment ?? 0;
      $obj->use_points_per_order = $request->use_points_per_order ?? 0;
      $obj->min_order_cart_value_redemption = $request->min_order_cart_value_redemption ?? 0;
      $obj->currency_value = $request->currency_value ?? 0;
      $obj->point_value = $request->point_value ?? 0;
      $obj->redemption_point_value = $request->redemption_point_value ?? 0;
      $obj->redemption_currency_value = $request->redemption_currency_value ?? 0;
      $obj->epoint_first_signup_value = $request->epoint_first_signup_value ?? 0;
      $obj->epoint_forder_point_value = $request->epoint_forder_point_value ?? 0;
      $obj->epoint_freview_point_value = $request->epoint_freview_point_value ?? 0;
      $obj->epoint_fpay_point_value = $request->epoint_fpay_point_value ?? 0;
      $obj->epoint_bday_point_value = $request->epoint_bday_point_value ?? 0;
      $obj->enable_show_customer_points = $request->enable_show_customer_points ? 1 : 0;
      $obj->enable_show_points_with_order = $request->enable_show_points_with_order ? 1 : 0;
      $obj->enable_show_points_by_mail = $request->enable_show_points_by_mail ? 1 : 0;

        if ($obj->save()) {
            return redirect(non_localized_url())
                ->with('success', trans('rewardpoints::messages.settings_have_been_saved'));
        } else {
            return redirect(non_localized_url())
                ->with('errors', trans('rewardpoints::messages.settings_update_failed'));
        }
    }

    private function handleMaintenanceMode($request)
    {
        if ($request->maintenance_mode) {
            Artisan::call('down');
        } elseif (app()->isDownForMaintenance()) {
            Artisan::call('up');
        }
    }

    public function customerlist()
    {
        $users = new $this->model;
        // dd($users->customers());
        // return view("{$this->viewPath}.index");


    }


    //     public function listcustomersrewardpoints()
    //     {

    //     //     $rewardpoint = $this->model::all();

    //     // // if (!$rewardpoint) {
    //     // //     // Handle the case where the rewardpoint is not found
    //     // //     abort(404);
    //     // // }

    //     // $customers = $rewardpoint->listCustomers();
    //     // dd($customers);
    //     // return view('rewardpoints.show_customers', compact('customers', 'rewardpoint'));

    //     $rewardpoints = Rewardpoint::all();

    //     // Initialize an empty array to store customer data
    //     $customers = [];

    //     // Loop through each reward point to fetch its associated customers
    //     foreach ($rewardpoints as $rewardpoint) {
    //         $customers[] = $rewardpoint->listCustomers();
    //     }
    //     return view('admin.create', compact('customers'));
    // }

}
