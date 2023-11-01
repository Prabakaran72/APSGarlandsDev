<?php

namespace Modules\Customer\Sidebar;

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
            $item->item(trans('customer::customers.customers'), function (Item $item) {
                $item->icon('fa fa-file');
                $item->weight(11);
                $item->route('admin.customers.index');
                $item->authorize(
                    $this->auth->hasAccess('admin.customers.index')
                );
            });
        });
        });
    }
}

