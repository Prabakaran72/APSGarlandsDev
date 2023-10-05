<?php

namespace Modules\Testimonial\Http\Controllers\Admin;

use Modules\Testimonial\Entities\Testimonial;
use Modules\Admin\Traits\HasCrudActions;
use Modules\Testimonial\Http\Requests\SaveTestimonialRequest;

class TestimonialController
{
    use HasCrudActions;

    /**
     * Model for the resource.
     *
     * @var string
     */
    protected $model = Testimonial::class;

    /**
     * Label of the resource.
     *
     * @var string
     */
    protected $label = 'testimonial::testimonials.testimonial';

    /**
     * View path of the resource.
     *
     * @var string
     */
    protected $viewPath = 'testimonial::admin.testimonials';

    /**
     * Form requests for the resource.
     *
     * @var array|string
     */
    protected $validation = SaveTestimonialRequest::class;
}
