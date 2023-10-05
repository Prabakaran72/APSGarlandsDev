<?php

namespace Modules\Customer\Http\Requests;

use Illuminate\Validation\Rule;
use Modules\Customer\Entities\Customer;
use Modules\Core\Http\Requests\Request;

class SaveCustomerRequest extends Request
{
    /**
     * Available attributes.
     *
     * @var array
     */
    protected $availableAttributes = 'customer::attributes';

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            // 'slug' => $this->getSlugRules(),
            'first_name' => 'required',
            'last_name' => 'required',
            'email' => 'required|email',
            'phone' =>  [
                'required',
                'regex:/^[0-9]{10}$/' 
            ],
            'address_1' => 'required',
            'state'=>'required',
            'city' => 'required',
            'zip' => 'required',
            // 'is_active' => 'required|boolean',
        ];
    }

    // private function getSlugRules()
    // {
    //     $rules = $this->route()->getName() === 'admin.customers.update'
    //         ? ['required']
    //         : ['sometimes'];

    //     $slug = Customer::withoutGlobalScope('active')->where('id', $this->id)->value('slug');

    //     $rules[] = Rule::unique('customers', 'slug')->ignore($slug, 'slug');

    //     return $rules;
    // }
}
