<?php

namespace Modules\Recurring\Sidebar;

use Maatwebsite\Sidebar\Item;
use Maatwebsite\Sidebar\Menu;
use Maatwebsite\Sidebar\Group;
use Modules\Admin\Sidebar\BaseSidebarExtender;

class SidebarExtender extends BaseSidebarExtender
{
    public function extend(Menu $menu)
    {
        
        $menu->group(trans('admin::sidebar.content'), function (Group $group) {
            $group->item(trans('admin::sidebar.sales'), function (Item $item) {
                $item->item(trans('recurring::recurrings.recurrings'), function (Item $item) {
                    $item->weight(30);
                    $item->route('admin.recurrings.index');
                    $item->authorize(
                        $this->auth->hasAccess('admin.recurrings.index')
                    );
                });
            });
        });
    }
}
