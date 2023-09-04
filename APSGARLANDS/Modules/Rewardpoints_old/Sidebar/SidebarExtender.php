<?php

namespace Modules\Rewardpoints\Sidebar;

use Maatwebsite\Sidebar\Item;
use Maatwebsite\Sidebar\Menu;
use Maatwebsite\Sidebar\Group;
use Modules\Admin\Sidebar\BaseSidebarExtender;

class SidebarExtender extends BaseSidebarExtender
{
    public function extend(Menu $menu)
    {
        $menu->group(trans('admin::sidebar.content'), function (Group $group) {
            $group->item(trans('rewardpoints::rewardpoints.rewardpoints'), function (Item $item) {
                $item->icon('fa fa-tags');
                $item->weight(15);
                $item->route('admin.rewardpoints.index');
                $item->authorize(
                    $this->auth->hasAnyAccess(['admin.rewardpoints.index', 'admin.rewardpointsgifts.index'])
                );

                $item->item(trans('rewardpoints::rewardpoints.rewardpoints'), function (Item $item) {
                    $item->weight(5);
                    $item->route('admin.rewardpoints.create');
                    $item->authorize(
                        $this->auth->hasAccess('admin.rewardpoints.create')
                    );
                });
            });
        });
    }
}