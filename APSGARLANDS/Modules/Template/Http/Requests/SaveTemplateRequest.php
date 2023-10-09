<?php

namespace Modules\Template\Http\Requests;

use Illuminate\Validation\Rule;
use Modules\Template\Entities\Template;
use Modules\Core\Http\Requests\Request;

class SaveTemplateRequest extends Request
{
    /**
     * Available attributes.
     *
     * @var array
     */
    protected $availableAttributes = 'template::attributes';

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'slug' => $this->getSlugRules(),
            'name' => 'required',
            'body' => 'required',
            'is_active' => 'required|boolean',
        ];
    }

    private function getSlugRules()
    {
        $rules = $this->route()->getName() === 'admin.templates.update'
            ? ['required']
            : ['sometimes'];

        $slug = Template::withoutGlobalScope('active')->where('id', $this->id)->value('slug');

        $rules[] = Rule::unique('templates', 'slug')->ignore($slug, 'slug');

        return $rules;
    }
}
