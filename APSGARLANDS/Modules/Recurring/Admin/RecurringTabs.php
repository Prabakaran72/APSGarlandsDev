<?php

namespace Modules\Recurring\Admin;

use Modules\Admin\Ui\Tab;
use Modules\Admin\Ui\Tabs;
use Modules\Recurring\Entities\Recurring;
use Modules\Category\Entities\Category;

class RecurringTabs extends Tabs
{
    public function make()
    {
        $this->group('recurring_information', trans('recurring::recurrings.tabs.group.recurring_information'))
            ->active()
            ->add($this->general());
    }

    public function general()
    {
        return tap(new Tab('general', trans('recurring::recurrings.tabs.general')), function (Tab $tab) {
            $tab->active();
            $tab->weight(5);

            // $tab->fields([
            //     'name',
            //     'comment',
            //     'is_percent',
            //     'value',
            //     'free_shipping',
            //     'start_date',
            //     'end_date',
            //     'is_active',
            // ]);

            $tab->view('recurring::admin.recurrings.tabs.general');
        });
    }
}
