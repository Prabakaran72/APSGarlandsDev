<?php

namespace Modules\Customer\Admin;

use Modules\Admin\Ui\Tab;
use Modules\Admin\Ui\Tabs;
use Modules\Support\Country;
use Modules\Support\State;

class CustomerTabs extends Tabs
{
    public function make()
    {
        $this->group('customer_information', trans('customer::customers.tabs.group.customer_information'))
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
        return tap(new Tab('general', trans('customer::customers.tabs.general')), function (Tab $tab) {
            $tab->active();
            $tab->weight(10);
            $tab->fields(['customers.first_name', 'customers.last_name', 'customers.phone','customers.address_2', 'customers.email', 'customers.address_1', 'customers.city', 'customers.country', 'customers.state', 'customers.zip']);
            $tab->view('customer::admin.customers.tabs.general', [
                'countries' => Country::all(),
            ]);
        });
            
    }

    private function seo()
    {
        return tap(new Tab('seo', trans('customer::customers.tabs.seo')), function (Tab $tab) {
            $tab->weight(10);
            $tab->view('customer::admin.customers.tabs.seo');
        });
    }
}
