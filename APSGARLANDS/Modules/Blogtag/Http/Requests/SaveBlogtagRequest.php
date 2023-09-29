<?php

namespace Modules\Blogtag\Http\Requests;

use Illuminate\Validation\Rule;
use Modules\Blogtag\Entities\Blogtag;
use Modules\Core\Http\Requests\Request;

class SaveBlogtagRequest extends Request
{
    /**
     * Available attributes.
     *
     * @var array
     */
    protected $availableAttributes = 'blogtag::attributes';

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            // 'slug' => '',
            'tag_name' => 'required',
            'tag_code' => 'required',
            // 'description' => 'required|boolean',
        ];
    }

    private function getSlugRules()
    {
        $rules = $this->route()->getName() === 'admin.blogtags.update'
            ? ['required']
            : ['sometimes'];

        $slug = Blogtag::withoutGlobalScope('active')->where('id', $this->id)->value('slug');

        $rules[] = Rule::unique('blogtags', 'slug')->ignore($slug, 'slug');

        return $rules;
    }
}
