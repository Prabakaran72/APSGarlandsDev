<?php

namespace Modules\Galleries\Http\Requests;

use Modules\Core\Http\Requests\Request;

class UploadGalleriesRequest extends Request
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'file' => 'file',
        ];
    }
}
