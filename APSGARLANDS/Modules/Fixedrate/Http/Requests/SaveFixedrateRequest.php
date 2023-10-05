<?php

namespace Modules\Fixedrate\Http\Requests;

use Illuminate\Validation\Rule;
use Modules\Fixedrate\Entities\Fixedrate;
use Modules\Core\Http\Requests\Request;

class SaveFixedrateRequest extends Request
{
    /**
     * Available attributes.
     *
     * @var array
     */
    protected $availableAttributes = 'fixedrate::attributes';

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        
        return [
            'slug' => '',
            'pincode' => 'required',
            'flat_price' => 'required',
            'is_active' => 'required|boolean',
        ];
    }

    private function getSlugRules()
    {
        $rules = $this->route()->getName() === 'admin.fixedrates.update'
            ? ['required']
            : ['sometimes'];

        $slug = Fixedrate::withoutGlobalScope('active')->where('id', $this->id)->value('slug');

        $rules[] = Rule::unique('fixedrates', 'slug')->ignore($slug, 'slug');

        return $rules;
    }
}
