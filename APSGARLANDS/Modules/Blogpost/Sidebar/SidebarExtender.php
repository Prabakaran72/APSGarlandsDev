<?php

namespace Modules\Blogpost\Sidebar;

use Maatwebsite\Sidebar\Item;
use Maatwebsite\Sidebar\Menu;
use Maatwebsite\Sidebar\Group;
use Modules\Admin\Sidebar\BaseSidebarExtender;

class SidebarExtender extends BaseSidebarExtender
{
    public function extend(Menu $menu)
    {



                $menu->group(trans('admin::sidebar.system'), function (Group $group) {
                    $group->item(trans('blogpost::sidebar.blog'), function (Item $item) {
                        $item->item(trans('blogpost::sidebar.blogpost'), function (Item $item) {
                            $item->weight(10);
                            $item->route('admin.blogposts.index');
                            $item->authorize(
                                $this->auth->hasAccess('admin.blogposts.index')
                            );
                        });
                    });
                });



    }
}
