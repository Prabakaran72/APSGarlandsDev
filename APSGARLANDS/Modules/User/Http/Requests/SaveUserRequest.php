<?php

namespace Modules\User\Http\Requests;

use Illuminate\Validation\Rule;
use Modules\Core\Http\Requests\Request;

class SaveUserRequest extends Request
{
    /**
     * Available attributes.
     *
     * @var string
     */
    protected $availableAttributes = 'user::attributes.users';

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        $rules =  [
            'first_name' => 'required',
            'last_name' => 'required',
            'email' => ['required', 'email', $this->emailUniqueRule()],
            'phone' => ['required'],
            'password' => 'nullable|confirmed|min:6',
            'roles' => ['required', Rule::exists('roles', 'id')],
        ];

          // Conditional validation based on user_type
          if ($this->input('user_type')) {
            $rules = array_merge($rules, [
                'address_1' => 'required',
                'city' => 'required',
                'zip' => 'required',
                'country' => 'required',
                'state' => 'required',
            ]);
        }

        return $rules;
    }

    private function emailUniqueRule()
    {
        $rule = Rule::unique('users');

        if ($this->route()->getName() === 'admin.users.update') {
            $userId = $this->route()->parameter('id');

            return $rule->ignore($userId);
        }

        return $rule;
    }
}
