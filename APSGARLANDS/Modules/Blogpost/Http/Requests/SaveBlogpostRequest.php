<?php

namespace Modules\Blogpost\Http\Requests;

use Illuminate\Validation\Rule;
use Modules\Blogpost\Entities\Blogpost;
use Modules\Core\Http\Requests\Request;

class SaveBlogpostRequest extends Request
{
    /**
     * Available attributes.
     *
     * @var array
     */
    protected $availableAttributes = 'blogpost::attributes';

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            // 'slug' => '',
            'post_title' => 'required',
            'post_body' => 'required',
            'post_body' => 'required',
            'tag_id' => 'required',
         'category_id' => 'required',
        ];
    }

    private function getSlugRules()
    {
        $rules = $this->route()->getName() === 'admin.blogposts.update'
            ? ['required']
            : ['sometimes'];

        $slug = Blogpost::withoutGlobalScope('active')->where('id', $this->id)->value('slug');

        $rules[] = Rule::unique('blogposts', 'slug')->ignore($slug, 'slug');

        return $rules;
    }
}
