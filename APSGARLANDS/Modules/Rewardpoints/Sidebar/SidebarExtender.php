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
                $item->icon('fa fa-gift');
                $item->weight(20);
                $item->route('admin.rewardpoints.edit');
                $item->authorize(
                    $this->auth->hasAccess('admin.rewardpoints.edit')
                );

                $item->item(trans('rewardpoints::rewardpoints.rewardpoints_settings'), function (Item $item) {
                    $item->weight(5);
                    $item->route('admin.rewardpoints.edit');
                    $item->authorize(
                        $this->auth->hasAccess('admin.rewardpoints.edit')
                    );
                });

                $item->item(trans('rewardpointsgift::rewardpointsgifts.title'), function (Item $item) {
                    $item->weight(27);
                    $item->route('admin.rewardpointsgift.index');
                    $item->authorize(
                        $this->auth->hasAccess('admin.rewardpointsgift.index')
                    );
                });
                
                $item->item(trans('rewardpointsgift::customerrewardpoints.title'), function (Item $item) {
                    $item->weight(27);
                    $item->route('admin.customerrewardpoints.index');
                    $item->authorize(
                        $this->auth->hasAccess('admin.customerrewardpoints.index')
                    );
                });


            });
        });
    }
}