<?php

namespace Modules\Blogtag\Admin;

use Modules\Admin\Ui\Tab;
use Modules\Admin\Ui\Tabs;

class BlogtagTabs extends Tabs
{
    public function make()
    {
        $this->group('blogtag_information', trans('blogtag::blogtags.tabs.group.blogtag_information'))
            ->active()
            ->add($this->general());
            //->add($this->seo());
    }

    private function general()
    {
        return tap(new Tab('general', trans('blogtag::blogtags.tabs.general')), function (Tab $tab) {
            $tab->active();
            $tab->weight(5);
            $tab->fields(['title', 'body', 'is_active', 'slug']);
            $tab->view('blogtag::admin.blogtags.tabs.general');
        });
    }

    // private function seo()
    // {
    //     return tap(new Tab('seo', trans('blogtag::blogtags.tabs.seo')), function (Tab $tab) {
    //         $tab->weight(10);
    //         $tab->view('blogtag::admin.blogtags.tabs.seo');
    //     });
    // }
}
