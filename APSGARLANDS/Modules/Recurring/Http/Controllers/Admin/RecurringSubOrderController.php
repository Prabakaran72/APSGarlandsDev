<?php

namespace Modules\Recurring\Http\Controllers\admin;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Recurring\Entities\Recurring;
use Modules\Recurring\Entities\RecurringSubOrder;
use Modules\User\Entities\User;
use Modules\Order\Entities\order;
use Illuminate\Support\Facades\Response;
use Modules\Recurring\Http\Requests\SaveRecurringRequest;
use Modules\Admin\Traits\HasCrudActions;
use Carbon\Carbon;
use Modules\Admin\Ui\AdminTable;
use Illuminate\Support\Facades\DB;


class RecurringSubOrderController extends Controller
{
    use HasCrudActions;
    protected $model = recurringSubOrder::class;
    protected $label = 'recurring::recurrings.recurringsuborder';

    public function edit($id)
    {
        $recurringMainOrders = Recurring::find($id);
        $created_id = $recurringMainOrders->created_user_id;

        if (!$recurringMainOrders) {
            // Handle the case where the Recurring record does not exist.
            // You might want to return a 404 response or handle it in some way.
        }

        // Retrieve all associated RecurringSubOrder records
        $recurringSubOrders = $recurringMainOrders->recurringSubOrders()->paginate('20');

        // Pass the data to a view
        return view('recurring::admin.recurrings.RecurringSubOrder', compact('recurringMainOrders', 'recurringSubOrders'));
    }

    public function orderToRecurringRedirection($id){

        $RecurringData =  Recurring::where('order_id', $id)->first();
        $recurringMainOrders = Recurring::find($RecurringData->id);
        $recurringSubOrders = $recurringMainOrders->recurringSubOrders()->paginate('20');
        return view('recurring::admin.recurrings.RecurringSubOrder', compact('recurringMainOrders', 'recurringSubOrders'));
    }

    public function unsubscribeMultipleOrder(Request $request)
    {

        $indianTimezone = 'Asia/Kolkata';

        $currentDateTime = Carbon::now($indianTimezone);

        $formattedDateTime = $currentDateTime->format('Y-m-d H:i:s');

        // Get the selected order_ids from the AJAX request
        $selectedOrderIds = $request->input('selectedIds');

        $affectedRows = RecurringSubOrder::whereIn('id', $selectedOrderIds)->update(['subscribe_status' => '0', 'updated_user_id' => auth()->id(), 'updated_at' => $formattedDateTime]);

        if ($affectedRows > 0) {
            return response()->json(['message' => 'update']);
        } else {
            return response()->json(['message' => 'not']);
        }
    }
}
