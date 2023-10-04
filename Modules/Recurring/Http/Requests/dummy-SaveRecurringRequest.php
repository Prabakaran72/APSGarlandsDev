<?php

namespace Modules\Recurring\Http\Requests;

use Modules\Core\Http\Requests\Request;

class SaveRecurringRequest extends Request
{
    /**
     * Available attributes.
     *
     * @var string
     */
    protected $availableAttributes = 'recurring::attributes';

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        // return [
        //     'user_name' => 'required',
        //     'comment' => 'required',
        //     'is_active' => 'required|boolean',
        // ];
    }
}
