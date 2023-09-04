<?php

namespace Modules\Testimonial\Admin;

use Modules\Admin\Ui\AdminTable;

class TestimonialTable extends AdminTable
{
    /**
     * Make table response for the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function make()
    {
        return $this->newTable()
            ->addColumn('discount', function ($testimonial) {
                return $testimonial->is_percent
                    ? "{$testimonial->value}%"
                    : $testimonial->value->format();
            });
    }
}
