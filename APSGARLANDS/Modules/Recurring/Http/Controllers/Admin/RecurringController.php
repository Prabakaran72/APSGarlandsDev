<?php

namespace Modules\Recurring\Http\Controllers\Admin;

use Illuminate\Http\Request;
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


    public function list_recurring_main_orders(Request $request)
    {
        if ($request->has('query')) {
            return $this->getModel()
                ->search($request->get('query'))
                ->query()
                ->limit($request->get('limit', 10))
                ->get();
        }

        if ($request->has('table')) {
            return $this->getModel()->table($request);
        }

        return view("{$this->viewPath}.index");

    }
}
