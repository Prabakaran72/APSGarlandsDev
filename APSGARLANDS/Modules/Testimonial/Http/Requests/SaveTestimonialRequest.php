<?php

namespace Modules\Testimonial\Http\Requests;

use Modules\Core\Http\Requests\Request;

class SaveTestimonialRequest extends Request
{
    /**
     * Available attributes.
     *
     * @var string
     */
    protected $availableAttributes = 'testimonial::attributes';

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'user_name' => 'required',
            'comment' => 'required',
            'is_active' => 'required|boolean',
        ];
    }
}
