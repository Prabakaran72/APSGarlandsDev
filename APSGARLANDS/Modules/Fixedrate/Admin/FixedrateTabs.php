<?php

namespace Modules\Fixedrate\Admin;

use Modules\Admin\Ui\Tab;
use Modules\Admin\Ui\Tabs;

class FixedrateTabs extends Tabs
{
    public function make()
    {
        $this->group('fixedrate_information', trans('fixedrate::fixedrates.tabs.group.fixedrate_information'))
            ->active()
            ->add($this->general());
    }

    private function general()
    {
        return tap(new Tab('general', trans('fixedrate::fixedrates.tabs.general')), function (Tab $tab) {
            $tab->active();
            $tab->weight(5);
            $tab->fields(['pincode', 'flat_price', 'is_active', 'slug']);
            $tab->view('fixedrate::admin.fixedrates.tabs.general');
        });
    }

    private function seo()
    {
        return tap(new Tab('seo', trans('fixedrate::fixedrates.tabs.seo')), function (Tab $tab) {
            $tab->weight(10);
            $tab->view('fixedrate::admin.fixedrates.tabs.seo');
        });
    }
}
