<?php

namespace Modules\Blogcategory\Http\Controllers\Admin;

use Modules\Blogcategory\Entities\Blogcategory;
use Modules\Admin\Traits\HasCrudActions;
use Modules\blogcategory\Http\Requests\SaveBlogcategoryRequest;

class BlogcategoryController
{
    use HasCrudActions;

    /**
     * Model for the resource.
     *
     * @var string
     */
    protected $model = Blogcategory::class;

    /**
     * Label of the resource.
     *
     * @var string
     */
    protected $label = 'blogcategory::blogcategorys.blogcategory';

    /**
     * View path of the resource.
     *
     * @var string
     */
    protected $viewPath = 'blogcategory::admin.blogcategorys';

    /**
     * Form requests for the resource.
     *
     * @var array|string
     */
    protected $validation = SaveBlogcategoryRequest::class;
}
