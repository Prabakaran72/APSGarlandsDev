<?php

namespace Modules\OrderSubscription\Http\Requests;

use Illuminate\Validation\Rule;
use Modules\OrderSubscription\Entities\OrderSubscription;
use Modules\Core\Http\Requests\Request;

class SaveOrderSubscriptionRequest extends Request
{
    /**
     * Available attributes.
     *
     * @var string
     */
    protected $availableAttributes = 'ordersubscription::attributes';

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'name' => 'required',
            'slug' => $this->getSlugRules(),
            'is_active' => 'required|boolean',
            'is_active' => 'required|boolean',
        ];
    }

    private function getSlugRules()
    {
        $rules = $this->route()->getName() === 'admin.ordersubscriptions.update'
            ? ['required']
            : ['nullable'];

        $slug = OrderSubscription::withoutGlobalScope('active')->where('id', $this->id)->value('slug');

        $rules[] = Rule::unique('ordersubscriptions', 'slug')->ignore($slug, 'slug');

        return $rules;
    }
}
