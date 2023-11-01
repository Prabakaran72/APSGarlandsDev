<?php

namespace Modules\Template\Sidebar;

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
                $item->item(trans('template::sidebar.templates'), function (Item $item) {
                    $item->weight(25);
                    $item->route('admin.templates.index');
                    $item->authorize(
                        $this->auth->hasAccess('admin.templates.index')
                    );
                });
            });
          
        });
    }
}
// public function extend(Menu $menu)
// {
//     $menu->group(trans('admin::sidebar.content'), function (Group $group) {
//         $group->item(trans('subscriber::subscribers.newsletter'), function (Item $item) {
//             $item->icon('fa fa-file');
//             $item->weight(25);
//             $item->route('admin.subscribers.index');
//             $item->authorize(
//                 $this->auth->hasAccess('admin.subscribers.index')
//             );
//             $item->item(trans('subscriber::sidebar.subscribers'), function (Item $item) {
//                 $item->weight(25);
//                 $item->route('admin.subscribers.index');
//                 $item->authorize(
//                     $this->auth->hasAccess('admin.subscribers.index')
//                 );
//             });
//         });
        
//     });
// }
//}

