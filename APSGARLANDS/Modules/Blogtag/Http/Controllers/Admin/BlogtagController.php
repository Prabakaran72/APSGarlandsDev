<?php

namespace Modules\Blogtag\Http\Controllers\Admin;

use Modules\Blogtag\Entities\Blogtag;
use Modules\Admin\Traits\HasCrudActions;
use Modules\blogtag\Http\Requests\SaveBlogtagRequest;

class BlogtagController
{
    use HasCrudActions;

    /**
     * Model for the resource.
     *
     * @var string
     */
    protected $model = Blogtag::class;

    /**
     * Label of the resource.
     *
     * @var string
     */
    protected $label = 'blogtag::blogtags.blogtag';

    /**
     * View path of the resource.
     *
     * @var string
     */
    protected $viewPath = 'blogtag::admin.blogtags';

    /**
     * Form requests for the resource.
     *
     * @var array|string
     */
    protected $validation = SaveBlogtagRequest::class;
}
