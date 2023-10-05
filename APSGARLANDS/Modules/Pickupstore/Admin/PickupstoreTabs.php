<?php

namespace Modules\Pickupstore\Admin;

use Modules\Admin\Ui\Tab;
use Modules\Admin\Ui\Tabs;
use Modules\Support\Locale;
use Modules\Support\Country;
use Modules\Support\TimeZone;
use Modules\Currency\Currency;
use Modules\User\Entities\Role;
class PickupstoreTabs extends Tabs
{
    public function make()
    {
        $this->group('pickupstore_information', trans('pickupstore::pickupstore.tabs.group.pickupstore_information'))
            ->active()
            ->add($this->general());
    }

    private function general()
    {
        return tap(new Tab('general', trans('pickupstore::pickupstore.tabs.general')), function (Tab $tab) {
            $tab->active();
            $tab->weight(10);
            $tab->fields(['translatable.store_name', 'translatable.store_tagline', 'store_phone', 'store_email', 'store_address_1', 'store_address_2', 'store_city', 'store_country', 'store_state', 'store_zip']);
            $tab->view('pickupstore::admin.pickupstores.tabs.general', [
                'countries' => Country::all(),
            ]);
            
        });
    }
    private function storeds()
    {
        return tap(new Tab('store', trans('setting::settings.tabs.store')), function (Tab $tab) {
            $tab->weight(10);

            $tab->fields(['translatable.store_name', 'translatable.store_tagline', 'store_phone', 'store_email', 'store_address_1', 'store_address_2', 'store_city', 'store_country', 'store_state', 'store_zip']);

            $tab->view('setting::admin.settings.tabs.store', [
                'countries' => Country::all(),
            ]);
        });
    }
    private function seo()
    {
        return tap(new Tab('seo', trans('pickupstore::pickupstore.tabs.seo')), function (Tab $tab) {
            $tab->weight(10);
            $tab->view('pickupstore::admin.pickupstores.tabs.seo');
        });
    }
}
