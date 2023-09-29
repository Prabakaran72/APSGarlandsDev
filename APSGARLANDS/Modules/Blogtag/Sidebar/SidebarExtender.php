<?php

namespace Modules\Blogtag\Sidebar;

use Maatwebsite\Sidebar\Item;
use Maatwebsite\Sidebar\Menu;
use Maatwebsite\Sidebar\Group;
use Modules\Admin\Sidebar\BaseSidebarExtender;

class SidebarExtender extends BaseSidebarExtender
{
    public function extend(Menu $menu)
    {



                $menu->group(trans('admin::sidebar.system'), function (Group $group) {
                    $group->item(trans('blogtag::sidebar.blog'), function (Item $item) {
                        $item->item(trans('blogtag::sidebar.blogtag'), function (Item $item) {
                            $item->weight(10);
                            $item->route('admin.blogtags.index');
                            $item->authorize(
                                $this->auth->hasAccess('admin.blogtags.index')
                            );
                        });
                    });
                });



    }
}
