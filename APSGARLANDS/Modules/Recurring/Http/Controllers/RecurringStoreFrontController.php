<?php

namespace Modules\Recurring\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
// use \Darryldecode\Cart\Cart;
use Modules\Cart\Facades\Cart;

class RecurringStoreFrontController extends Controller
{

    public function updateRecurringSubTotal($recurringSubTotAmt)
    {
        //  dd("recurringSubTotAmt",$recurringSubTotAmt);
        $recurringDateCount = 12;
        // $cart = Cart::instance();
        // $cart->total($recurringSubTotAmt);
        Cart::recurringsubTotal($recurringSubTotAmt);
        // dd( $cart->getSubTotal(false, $recurringSubTotAmt));
        // dd(Cart::instance());
        return Cart::instance();
    }
}
