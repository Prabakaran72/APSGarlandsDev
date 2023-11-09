<?php

namespace Modules\Recurring\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
// use \Darryldecode\Cart\Cart;
use Modules\Cart\Facades\Cart;
use Modules\Recurring\Entities\Recurring;
use Modules\Recurring\Entities\recurringSubOrder;

class RecurringStoreFrontController extends Controller
{

    public function updateRecurringSubTotal(Request $request)
    {
        // dd($request->recurringDateCount);
        Cart::recurringsubTotal($request->recurringDateCount);
        return Cart::instance();
    }
}
