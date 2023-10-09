<?php

namespace Modules\Email\Http\Controllers\Admin;

use Modules\Email\Entities\Email;
use Modules\Admin\Traits\HasCrudActions;
use Modules\Email\Http\Requests\SaveEmailRequest;

class EmailController
{
    use HasCrudActions;

    /**
     * Model for the resource.
     *
     * @var string
     */
    protected $model = Email::class;

    /**
     * Label of the resource.
     *
     * @var string
     */
    protected $label = 'email::emails.email';

    /**
     * View path of the resource.
     *
     * @var string
     */
    protected $viewPath = 'email::admin.emails';

    /**
     * Form requests for the resource.
     *
     * @var array|string
     */
    protected $validation = SaveEmailRequest::class;
}
