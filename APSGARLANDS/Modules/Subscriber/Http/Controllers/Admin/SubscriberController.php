<?php

namespace Modules\Subscriber\Http\Controllers\Admin;

use Modules\Subscriber\Entities\Subscriber;
use Modules\Admin\Traits\HasCrudActions;
use Modules\Subscriber\Http\Requests\SaveSubscriberRequest;

class SubscriberController
{
    use HasCrudActions;

    /**
     * Model for the resource.
     *
     * @var string
     */
    protected $model = Subscriber::class;

    /**
     * Label of the resource.
     *
     * @var string
     */
    protected $label = 'subscriber::subscribers.subscriber';

    /**
     * View path of the resource.
     *
     * @var string
     */
    protected $viewPath = 'subscriber::admin.subscribers';

    /**
     * Form requests for the resource.
     *
     * @var array|string
     */
    protected $validation = SaveSubscriberRequest::class;
}
