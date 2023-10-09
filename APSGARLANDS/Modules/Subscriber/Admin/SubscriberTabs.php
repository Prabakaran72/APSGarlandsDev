<?php

namespace Modules\Subscriber\Admin;

use Modules\Admin\Ui\Tab;
use Modules\Admin\Ui\Tabs;

class SubscriberTabs extends Tabs
{
    public function make()
    {
        $this->group('subscriber_information', trans('subscriber::subscribers.tabs.group.subscriber_information'))
            ->active();
            // ->add($this->general())
            // ->add($this->seo());
    }

    private function general()
    {
        return tap(new Tab('general', trans('subscriber::subscribers.tabs.general')), function (Tab $tab) {
            $tab->active();
            $tab->weight(5);
            $tab->fields(['title', 'body', 'is_active', 'slug']);
            $tab->view('subscriber::admin.subscribers.tabs.general');
        });
    }

    private function seo()
    {
        return tap(new Tab('seo', trans('subscriber::subscribers.tabs.seo')), function (Tab $tab) {
            $tab->weight(10);
            $tab->view('subscriber::admin.subscribers.tabs.seo');
        });
    }
}
