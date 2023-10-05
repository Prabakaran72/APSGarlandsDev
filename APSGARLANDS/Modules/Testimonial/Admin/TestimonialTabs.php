<?php

namespace Modules\Testimonial\Admin;

use Modules\Admin\Ui\Tab;
use Modules\Admin\Ui\Tabs;
use Modules\Testimonial\Entities\Testimonial;
use Modules\Category\Entities\Category;

class TestimonialTabs extends Tabs
{
    public function make()
    {
        $this->group('testimonial_information', trans('testimonial::testimonials.tabs.group.testimonial_information'))
            ->active()
            ->add($this->general());
    }

    public function general()
    {
        return tap(new Tab('general', trans('testimonial::testimonials.tabs.general')), function (Tab $tab) {
            $tab->active();
            $tab->weight(5);

            $tab->fields([
                'name',
                'comment',
                'is_percent',
                'value',
                'free_shipping',
                'start_date',
                'end_date',
                'is_active',
            ]);

            $tab->view('testimonial::admin.testimonials.tabs.general');
        });
    }
}
