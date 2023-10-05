<?php

namespace Modules\Pickupstore\Http\Controllers\Admin;

use Modules\Pickupstore\Entities\Pickupstore;
use Modules\Admin\Traits\HasCrudActions;
use Modules\Pickupstore\Http\Requests\SavePickupstoreRequest;

class PickupstoreController
{
    use HasCrudActions;

    /**
     * Model for the resource.
     *
     * @var string
     */
    protected $model = Pickupstore::class;

    /**
     * Label of the resource.
     *
     * @var string
     */
    protected $label = 'pickupstore::pickupstore.pickupstore';

    /**
     * View path of the resource.
     *
     * @var string
     */
    protected $viewPath = 'pickupstore::admin.pickupstores';

    /**
     * Form requests for the resource.
     *
     * @var array|string
     */
    protected $validation = SavePickupstoreRequest::class;
}
