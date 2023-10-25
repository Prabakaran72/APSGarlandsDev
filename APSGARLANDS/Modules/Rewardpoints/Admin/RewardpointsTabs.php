<?php

namespace Modules\Rewardpoints\Admin;

use Modules\Admin\Ui\Tab;
use Modules\Admin\Ui\Tabs;
use Modules\Rewardpoints\Entities\Rewardpoints;


class RewardpointsTabs extends Tabs
{
  
    public function make()
    {
        $this->group('rewardpoints_information', trans('rewardpoints::rewardpoints.tabs.group.rewardpoints_information'))
            ->active()
            ->add($this->settings())
            ->add($this->setpoints())
            // ->add($this->customerpoints())
            ->add($this->notifications())
            ;
    }

    public function settings()
    {
        return tap(new Tab('settings', trans('rewardpoints::rewardpoints.tabs.settings')), function (Tab $tab) {
            $tab->active();
            $tab->weight(5);

            $tab->fields([
                'name',
                'code',
                'is_percent',
                'value',
                'free_shipping',
                'start_date',
                'end_date',
                'is_active',
            ]);

            $tab->view('rewardpoints::admin.rewardpoints.tabs.settings');
        });
    }

    public function setpoints()
    {
        return tap(new Tab('setpoints', trans('rewardpoints::rewardpoints.tabs.setpoints')), function (Tab $tab) {
            $tab->weight(10);
            $tab->fields(['minimum_spend']);

            // $rewardpoints = Rewardpoints::withoutGlobalScope('active')->first();
            $rewardpoints = Rewardpoints::first();
            if($rewardpoints == null){
                $rewardpoints = new Rewardpoints();
            }
            $tab->view('rewardpoints::admin.rewardpoints.tabs.setpoints',compact('rewardpoints'));
        });
    }

        // private function customerpoints()
        // {
           
        //     return tap(new Tab('customerpoints', trans('rewardpoints::rewardpoints.tabs.customerpoints')), function (Tab $tab) {
        //         $obj = new Rewardpoints();
        //         $customer_list = $obj->customers();
        //         $tab->weight(15);
        //         $tab->fields(['usage_limit_per_rewardpoints', 'usage_limit_per_customer']);
        //         // $tab->view('rewardpoints::admin.rewardpoints.tabs.customerpoints',['rewardpoints'=>  $customer_list]);
        //         $tab->view('rewardpoints::admin.rewardpoints.tabs.customerpoints');
        //     });
        // }

    private function notifications()
    {
       
        return tap(new Tab('notifications', trans('rewardpoints::rewardpoints.tabs.notifications')), function (Tab $tab) {
            $rewardpoints = Rewardpoints::first();
            if($rewardpoints == null){
                $rewardpoints = new Rewardpoints();
            }

            $tab->weight(15);
            $tab->fields(['usage_limit_per_rewardpoints', 'usage_limit_per_customer']);
            $tab->view('rewardpoints::admin.rewardpoints.tabs.notifications',compact('rewardpoints'));
        });
    }
}
