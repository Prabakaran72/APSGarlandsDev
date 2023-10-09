<?php

namespace Modules\Template\Http\Controllers\Admin;

use Modules\Template\Entities\Template;
use Modules\Admin\Traits\HasCrudActions;
use Modules\Template\Http\Requests\SaveTemplateRequest;

class TemplateController
{
    use HasCrudActions;

    /**
     * Model for the resource.
     *
     * @var string
     */
    protected $model = Template::class;

    /**
     * Label of the resource.
     *
     * @var string
     */
    protected $label = 'template::templates.template';

    /**
     * View path of the resource.
     *
     * @var string
     */
    protected $viewPath = 'template::admin.templates';

    /**
     * Form requests for the resource.
     *
     * @var array|string
     */
    protected $validation = SaveTemplateRequest::class;
}
