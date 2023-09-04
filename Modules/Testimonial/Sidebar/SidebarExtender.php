<?php

namespace Modules\Testimonial\Sidebar;

use Maatwebsite\Sidebar\Item;
use Maatwebsite\Sidebar\Menu;
use Maatwebsite\Sidebar\Group;
use Modules\Admin\Sidebar\BaseSidebarExtender;

class SidebarExtender extends BaseSidebarExtender
{
    public function extend(Menu $menu)
    {
        $menu->group(trans('admin::sidebar.content'), function (Group $group) {
            $group->item(trans('testimonial::testimonials.testimonials'), function (Item $item) {
                $item->icon('fa fa-comments');
                $item->weight(20);
                $item->route('admin.testimonials.index');
                $item->authorize(
                    $this->auth->hasAccess('admin.testimonials.index')
                );
            });
        });
    }
}
