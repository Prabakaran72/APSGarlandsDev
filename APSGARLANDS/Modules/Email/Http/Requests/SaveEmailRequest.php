<?php

namespace Modules\Email\Http\Requests;

use Illuminate\Validation\Rule;
use Modules\Email\Entities\Email;
use Modules\Core\Http\Requests\Request;

class SaveEmailRequest extends Request
{
    /**
     * Available attributes.
     *
     * @var array
     */
    protected $availableAttributes = 'email::attributes';

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'subscribers' => 'required',
            'subject' => 'required',
            'template' => 'required',
            'template_id' => '',
            'date' => '',
            'is_active' => 'required|boolean',
           
        ];
    }

    private function getSlugRules()
    {
        $rules = $this->route()->getName() === 'admin.emails.update'
            ? ['required']
            : ['sometimes'];

        $slug = Email::withoutGlobalScope('active')->where('id', $this->id)->value('slug');

        $rules[] = Rule::unique('emails', 'slug')->ignore($slug, 'slug');

        return $rules;
    }
}
