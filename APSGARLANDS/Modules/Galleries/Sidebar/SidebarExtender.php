<?php

namespace Modules\Galleries\Sidebar;

use Maatwebsite\Sidebar\Item;
use Maatwebsite\Sidebar\Menu;
use Maatwebsite\Sidebar\Group;
use Modules\Admin\Sidebar\BaseSidebarExtender;

class SidebarExtender extends BaseSidebarExtender
{
    public function extend(Menu $menu)
    {
        $menu->group(trans('admin::sidebar.content'), function (Group $group) {
            $group->item(trans('galleries::galleries.galleries'), function (Item $item) {
                $item->weight(30);
                $item->icon('fa fa-camera');
                $item->route('admin.galleries.index');
                $item->authorize(
                    $this->auth->hasAccess('admin.galleries.index')
                );
            });
        });
    }
}
