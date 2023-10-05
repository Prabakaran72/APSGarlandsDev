<?php

namespace Modules\OrderSubscription\Http\Controllers\Admin;

use Modules\OrderSubscription\Entities\OrderSubscription;
use Modules\Admin\Traits\HasCrudActions;
use Modules\OrderSubscription\Http\Requests\SaveOrderSubscriptionRequest;

class OrderSubscriptionController
{
    use HasCrudActions;

    /**
     * Model for the resource.
     *
     * @var string
     */
    protected $model = OrderSubscription::class;

    /**
     * Label of the resource.
     *
     * @var string
     */
    protected $label = 'ordersubscription::ordersubscriptions.ordersubscription';

    /**
     * View path of the resource.
     *
     * @var string
     */
    protected $viewPath = 'ordersubscription::admin.ordersubscription';

    /**
     * Form requests for the resource.
     *
     * @var array|string
     */
    protected $validation = SaveOrderSubscriptionRequest::class;

    /**
     * Display the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        return OrderSubscription::with('files')->withoutGlobalScope('active')->find($id);
    }

    /**
     * Destroy resources by given ids.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        OrderSubscription::withoutGlobalScope('active')
            ->findOrFail($id)
            ->delete();

        return back()->withSuccess(trans('admin::messages.resource_deleted', ['resource' => $this->getLabel()]));
    }
}
