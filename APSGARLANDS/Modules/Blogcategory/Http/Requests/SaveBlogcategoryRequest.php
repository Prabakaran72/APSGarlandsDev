<?php

namespace Modules\Blogcategory\Http\Requests;

use Illuminate\Validation\Rule;
use Modules\Blogcategory\Entities\Blogcategory;
use Modules\Core\Http\Requests\Request;

class SaveBlogcategoryRequest extends Request
{
    /**
     * Available attributes.
     *
     * @var array
     */
    protected $availableAttributes = 'blogcategory::attributes';

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            // 'slug' => '',
            'category_name' => 'required',
            'category_code' => 'required',
            // 'description' => 'required|boolean',
        ];
    }

    private function getSlugRules()
    {
        $rules = $this->route()->getName() === 'admin.blogcategorys.update'
            ? ['required']
            : ['sometimes'];

        $slug = Blogcategory::withoutGlobalScope('active')->where('id', $this->id)->value('slug');

        $rules[] = Rule::unique('blogcategorys', 'slug')->ignore($slug, 'slug');

        return $rules;
    }
}
