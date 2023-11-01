<?php

namespace Modules\Template\Admin;

use Modules\Admin\Ui\Tab;
use Modules\Admin\Ui\Tabs;

class TemplateTabs extends Tabs
{
    public function make()
    {
        $this->group('template_information', trans('template::templates.tabs.group.template_information'))
            ->active()
            ->add($this->general())
            ->add($this->seo());
    }

    private function general()
    {
        return tap(new Tab('general', trans('template::templates.tabs.general')), function (Tab $tab) {
            $tab->active();
            $tab->weight(5);
            $tab->fields(['title', 'body', 'is_active', 'slug']);
            $tab->view('template::admin.templates.tabs.general');
        });
    }

    private function seo()
    {
        return tap(new Tab('seo', trans('template::templates.tabs.seo')), function (Tab $tab) {
            $tab->weight(10);
            $tab->view('template::admin.templates.tabs.seo');
        });
    }
}
