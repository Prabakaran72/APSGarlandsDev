<?php

namespace Modules\Recurring\Http\Controllers\Admin;

use Modules\Recurring\Entities\Recurring;
use Modules\Recurring\Entities\recurring_main_order;
use Modules\Admin\Traits\HasCrudActions;
use Modules\Recurring\Http\Requests\SaveRecurringRequest;


class RecurringController
{

    use HasCrudActions;

    /**
     * Model for the resource.
     *
     * @var string
     */

    protected $model = Recurring::class;

    /**
     * Label of the resource.
     *
     * @var string
     */
    protected $label = 'recurring::recurrings.recurring';

    /**
     * View path of the resource.
     *
     * @var string
     */
    protected $viewPath = 'recurring::admin.recurrings';

    /**
     * Form requests for the resource.
     *
     * @var array|string
     */
    protected $validation = SaveRecurringRequest::class;
}
