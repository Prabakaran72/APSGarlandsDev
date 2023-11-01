<?php

namespace Modules\Email\Admin;

use Modules\Admin\Ui\Tab;
use Modules\Admin\Ui\Tabs;

class EmailTabs extends Tabs
{
    public function make()
    {
        $this->group('email_information', trans('email::emails.tabs.group.email_information'))
            ->active()
            ->add($this->general());
            // ->add($this->seo());
    }

    private function general()
    {
        return tap(new Tab('general', trans('email::emails.tabs.general')), function (Tab $tab) {
            $tab->active();
            $tab->weight(5);
            $tab->fields(['title', 'body', 'is_active', 'slug']);
            $tab->view('email::admin.emails.tabs.general');
        });
    }

}
