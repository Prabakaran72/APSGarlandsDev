<?php

namespace Modules\Fixedrate\Http\Controllers\Admin;

use Modules\Fixedrate\Entities\Fixedrate;
use Modules\Admin\Traits\HasCrudActions;
use Modules\Fixedrate\Http\Requests\SaveFixedrateRequest;

class FixedrateController
{
    use HasCrudActions;

    /**
     * Model for the resource.
     *
     * @var string
     */
    protected $model = Fixedrate::class;

    /**
     * Label of the resource.
     *
     * @var string
     */
    protected $label = 'fixedrate::fixedrates.fixedrate';

    /**
     * View path of the resource.
     *
     * @var string
     */
    protected $viewPath = 'fixedrate::admin.fixedrates';

    /**
     * Form requests for the resource.
     *
     * @var array|string
     */
    protected $validation = SaveFixedrateRequest::class;
}
