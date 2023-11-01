<?php

namespace Modules\OrderSubscription\Sidebar;

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
                $item->item(trans('ordersubscription::ordersubscriptions.ordersubscription'), function (Item $item) {
                    $item->weight(10);
                    $item->route('admin.ordersubscription.index');
                    $item->authorize(
                        $this->auth->hasAccess('admin.ordersubscription.index')
                    );
                });
            });
        });
    }
}
