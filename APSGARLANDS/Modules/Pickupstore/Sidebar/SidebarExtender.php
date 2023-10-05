<?php

namespace Modules\Pickupstore\Sidebar;

use Maatwebsite\Sidebar\Item;
use Maatwebsite\Sidebar\Menu;
use Maatwebsite\Sidebar\Group;
use Modules\Admin\Sidebar\BaseSidebarExtender;

class SidebarExtender extends BaseSidebarExtender
{
    public function extend(Menu $menu)
    { 
        $menu->group(trans('admin::sidebar.content'), function (Group $group) {
            $group->item(trans('pickupstore::pickupstore.shippingmethods'), function (Item $item) {
                $item->icon('fa fa-truck');
                $item->weight(25);
                $item->route('admin.pickupstores.index');
                $item->authorize(
                    $this->auth->hasAnyAccess(['admin.pickupstores.index'])
                );
           
            $item->item(trans('pickupstore::sidebar.pickupstore'), function (Item $item) {
                $item->weight(25);
                $item->route('admin.pickupstores.index');
                $item->authorize(
                    $this->auth->hasAccess('admin.pickupstores.index')
                );
            });
        });
        });
    }
}
