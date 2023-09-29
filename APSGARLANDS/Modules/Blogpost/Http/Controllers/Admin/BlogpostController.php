<?php

namespace Modules\Blogpost\Http\Controllers\Admin;

use Modules\Blogpost\Entities\Blogpost;
use Modules\Admin\Traits\HasCrudActions;
use Modules\blogpost\Http\Requests\SaveBlogpostRequest;

class BlogpostController
{
    use HasCrudActions;

    /**
     * Model for the resource.
     *
     * @var string
     */
    protected $model = Blogpost::class;

    /**
     * Label of the resource.
     *
     * @var string
     */
    protected $label = 'blogpost::blogposts.blogpost';

    /**
     * View path of the resource.
     *
     * @var string
     */
    protected $viewPath = 'blogpost::admin.blogposts';

    /**
     * Form requests for the resource.
     *
     * @var array|string
     */
    protected $validation = SaveBlogpostRequest::class;
}
