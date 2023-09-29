<?php

namespace Modules\Blogcategory\Admin;

use Modules\Admin\Ui\Tab;
use Modules\Admin\Ui\Tabs;

class BlogcategoryTabs extends Tabs
{
    public function make()
    {
        $this->group('blogcategory_information', trans('blogcategory::blogcategorys.tabs.group.blogcategory_information'))
            ->active()
            ->add($this->general());
            //->add($this->seo());
    }

    private function general()
    {
        return tap(new Tab('general', trans('blogcategory::blogcategorys.tabs.general')), function (Tab $tab) {
            $tab->active();
            $tab->weight(5);
            $tab->fields(['title', 'body', 'slug']);
            $tab->view('blogcategory::admin.blogcategorys.tabs.general');
        });
    }

    // private function seo()
    // {
    //     return tap(new Tab('seo', trans('blogcategory::blogcategorys.tabs.seo')), function (Tab $tab) {
    //         $tab->weight(10);
    //         $tab->view('blogcategory::admin.blogcategorys.tabs.seo');
    //     });
    // }
}
