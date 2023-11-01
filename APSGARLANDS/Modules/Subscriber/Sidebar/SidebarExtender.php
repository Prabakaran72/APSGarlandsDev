<?php

namespace Modules\Subscriber\Sidebar;

use Maatwebsite\Sidebar\Item;
use Maatwebsite\Sidebar\Menu;
use Maatwebsite\Sidebar\Group;
use Modules\Admin\Sidebar\BaseSidebarExtender;

class SidebarExtender extends BaseSidebarExtender
{
    public function extend(Menu $menu)
    {
        $menu->group(trans('admin::sidebar.content'), function (Group $group) {
            $group->item(trans('subscriber::subscribers.newsletter'), function (Item $item) {
                $item->icon('fa fa-file');
                $item->weight(25);
                $item->route('admin.subscribers.index');
                $item->authorize(
                    $this->auth->hasAccess('admin.subscribers.index')
                );
                $item->item(trans('subscriber::sidebar.subscribers'), function (Item $item) {
                    $item->weight(25);
                    $item->route('admin.subscribers.index');
                    $item->authorize(
                        $this->auth->hasAccess('admin.subscribers.index')
                    );
                });
            });
            
        });
    }
}

// $menu->group(trans('admin::sidebar.content'), function (Group $group) {
//     $group->item(trans('pickupstore::pickupstore.shippingmethods'), function (Item $item) {
//         $item->icon('fa fa-truck');
//         $item->weight(25);
//         $item->route('admin.pickupstores.index');
//         $item->authorize(
//             $this->auth->hasAnyAccess(['admin.pickupstores.index'])
//         );
   
//     $item->item(trans('subscriber::sidebar.subscriber'), function (Item $item) {
//         $item->weight(25);
//         $item->route('admin.subscriber.index');
//         $item->authorize(
//             $this->auth->hasAccess('admin.subscriber.index')
//         );
//     });
// });
// });