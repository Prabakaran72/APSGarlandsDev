<?php

namespace Modules\Blogcategory\Sidebar;

use Maatwebsite\Sidebar\Item;
use Maatwebsite\Sidebar\Menu;
use Maatwebsite\Sidebar\Group;
use Modules\Admin\Sidebar\BaseSidebarExtender;

class SidebarExtender extends BaseSidebarExtender
{
    public function extend(Menu $menu)
    {

        $menu->group(trans('admin::sidebar.system'), function (Group $group) {
            $group->item(trans('blogcategory::sidebar.blog'), function (Item $item) {
                $item->icon('fa fa-rss');
                $item->weight(15);
                $item->route('admin.blogcategorys.index');
                $item->authorize(
                    $this->auth->hasAnyAccess(['admin.blogcategorys.index'])
                );

                $item->item(trans('blogcategory::sidebar.blogcategory'), function (Item $item) {
                    $item->weight(5);
                    $item->route('admin.blogcategorys.index');
                    $item->authorize(
                        $this->auth->hasAccess('admin.blogcategorys.index')
                    );
                });

            });
        });
    }
}
