<?php

namespace Modules\Blogpost\Admin;

use Modules\Admin\Ui\Tab;
use Modules\Admin\Ui\Tabs;
use Modules\Blogtag\Entities\Blogtag;
use Modules\Blogcategory\Entities\Blogcategory;

class BlogpostTabs extends Tabs
{
    public function make()
    {
        $this->group('blogpost_information', trans('blogpost::blogposts.tabs.group.blogpost_information'))
            ->active()
            ->add($this->general());
            //->add($this->seo());
    }

    private function general()
    {
        return tap(new Tab('general', trans('blogpost::blogposts.tabs.general')), function (Tab $tab) {
            $tab->active();
            $tab->weight(5);
            $tab->fields(['title', 'body', 'is_active', 'slug']);
            $tab->view('blogpost::admin.blogposts.tabs.general', [
                'blogggtags' => Blogtag::list(),
                'blogggcategorys' => Blogcategory::list()->prepend(trans('admin::admin.form.please_select'), ''),
            ]);
        });
    }


}
