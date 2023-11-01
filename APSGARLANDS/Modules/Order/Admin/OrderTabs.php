<?php

namespace Modules\Order\Admin;

use Modules\Admin\Ui\Tab;
use Modules\Admin\Ui\Tabs;
use Modules\Support\State;
use Modules\User\Entities\User;
class OrderTabs extends Tabs
{
    public function make()
    {
        $this->group('order_information', trans('order::orders.tabs.group.order_information'))
            ->active()
            ->add($this->general());
            
    }

    private function general()
    {
        // return tap(new Tab('general', trans('customer::customers.tabs.general')), function (Tab $tab) {
        //     $tab->active();
        //     $tab->weight(5);
        //     $tab->fields(['title', 'body', 'is_active', 'slug']);
        //     $tab->view('customer::admin.customers.tabs.general');
        // });
        return tap(new Tab('general', trans('order::orders.tabs.general')), function (Tab $tab) {
            $tab->active();
            $tab->weight(10);
            $tab->fields(['orders.id','orders.created_at']);
            $tab->view('order::orders.tabs.general', [
                'user' => User::all(),  
            ]);
        });
            
    }

    // private function seo()
    // {
    //     return tap(new Tab('seo', trans('customer::customers.tabs.seo')), function (Tab $tab) {
    //         $tab->weight(10);
    //         $tab->view('customer::admin.customers.tabs.seo');
    //     });
    // }
}
