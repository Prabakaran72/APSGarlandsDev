<?php

namespace Modules\Subscriber\Http\Requests;

use Illuminate\Validation\Rule;
use Modules\Subscriber\Entities\Subscriber;
use Modules\Core\Http\Requests\Request;

class SaveSubscriberRequest extends Request
{
    /**
     * Available attributes.
     *
     * @var array
     */
    protected $availableAttributes = 'subscriber::attributes';

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'email' => 'required|email',
            'is_active' => 'required|boolean',
        ];
        
    }

    // private function getSlugRules()
    // {
    //     $rules = $this->route()->getName() === 'admin.subscribers.update'
    //         ? ['required']
    //         : ['sometimes'];

    //     $slug = Subscriber::withoutGlobalScope('active')->where('id', $this->id)->value('slug');

    //     $rules[] = Rule::unique('subscribers', 'slug')->ignore($slug, 'slug');

    //     return $rules;
    // }
}
