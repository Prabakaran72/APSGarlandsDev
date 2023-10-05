<?php

namespace Modules\Pickupstore\Http\Requests;

use Illuminate\Validation\Rule;
use Modules\Pickupstore\Entities\Pickupstore;
use Modules\Core\Http\Requests\Request;
use Modules\Support\Country;


class SavePickupstoreRequest extends Request
{
    /**
     * Available attributes.
     *
     * @var array
     */
    protected $availableAttributes = 'pickupstore::attributes';

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'slug' => '',
            'name' => 'required',
            'tagline'=>'',
            'email' => 'email',
            'phone' => 'required|numeric',
            'address_1' => '',
            'address_2' => '',
            'city' => 'required',
            'store_state' => 'required',
            'store_country' => ['required', Rule::in(Country::codes())],
            'zip' => 'required|numeric',
            'is_active' => 'required|boolean',
        ];
    }

    private function getSlugRules()
    {
        $rules = $this->route()->getName() === 'admin.pickupstores.update'
            ? ['required']
            : ['sometimes'];

        $slug = Pickupstore::withoutGlobalScope('active')->where('id', $this->id)->value('slug');

        $rules[] = Rule::unique('pickupstores', 'slug')->ignore($slug, 'slug');

        return $rules;
    }
}
