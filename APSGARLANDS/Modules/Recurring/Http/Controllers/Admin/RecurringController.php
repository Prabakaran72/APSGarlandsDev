<?php

namespace Modules\Recurring\Http\Controllers\Admin;

use Illuminate\Http\Request;
use Modules\Recurring\Entities\Recurring;
use Modules\User\Entities\User;
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


    public function index(Request $request)
    {
        // dd($this->getModel());
        if ($request->has('query')) {
            return $this->getModel()
                // ->with['user']
                ->search($request->get('query'))
                ->query()
                ->limit($request->get('limit', 10))
                ->get();
        }

        if ($request->has('table')) {
            return $this->getModel()->table("12");
        }

        // $user = User::all();
        return view("{$this->viewPath}.index");

    }
}
