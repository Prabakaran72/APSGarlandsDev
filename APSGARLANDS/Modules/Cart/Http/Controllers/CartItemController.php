<?php

namespace Modules\Cart\Http\Controllers;

use Modules\Cart\Facades\Cart;
use Illuminate\Pipeline\Pipeline;
use Illuminate\Routing\Controller;
use Modules\Coupon\Checkers\MaximumSpend;
use Modules\Coupon\Checkers\MinimumSpend;
use Modules\Cart\Http\Requests\StoreCartItemRequest;
use Modules\Coupon\Exceptions\MaximumSpendException;
use Modules\Coupon\Exceptions\MinimumSpendException;
use Modules\Cart\Http\Middleware\CheckProductIsInStock;
use Modules\Cart\Entities\AbandonedListModel;

class CartItemController extends Controller
{
    private $checkers = [
        MinimumSpend::class,
        MaximumSpend::class,
    ];

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware(CheckProductIsInStock::class)->only(['store', 'update']);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Modules\Cart\Http\Requests\StoreCartItemRequest $request
     * @return \Illuminate\Http\Response
     */
    public function store(StoreCartItemRequest $request)
    {
        Cart::store($request->product_id, $request->qty, $request->options ?? []);

        return Cart::instance();
    }
    
    /**
     * Update the specified resource in storage.
     *
     * @param mixed $cartItemId
     * @return \Illuminate\Http\Response
     */
    public function update($cartItemId)
    {
        Cart::updateQuantity($cartItemId, request('qty'));

        try {
            resolve(Pipeline::class)
                ->send(Cart::coupon())
                ->through($this->checkers)
                ->thenReturn();
        } catch (MinimumSpendException | MaximumSpendException $e) {
            Cart::removeCoupon();
        }

        return Cart::instance();
    }    
    public function clearCartItem($cartItemId)
        {
        if(auth()->check() && auth()->user()->id){
            $customer_id=auth()->user()->id;
            $first_name=auth()->user()->first_name;
            $last_name=auth()->user()->last_name;

            $reason_destroy=request()->deleteReason;
            $cartItemallvalue=request()->cartItem;
            $slug_val=$cartItemallvalue['product']['slug'];
            $qty=$cartItemallvalue['qty'];
            $unitprice=$cartItemallvalue['unitPrice']['amount'];
            $product_id_val=$cartItemallvalue['product']['id'];
            $CartsAbandoned=AbandonedListModel::insert([
                'slug'=>$slug_val,
                'quantity'=>$qty,
                'rate'=>$unitprice,
                'customer_id'=>$customer_id,
                'product_id'=>$product_id_val,
                'reason'=>$reason_destroy,
                'first_name'=>$first_name,
                'last_name'=>$last_name,
        ]);
        }
        
     Cart::remove($cartItemId);
     return Cart::instance();
    }
     /*Get and Check */
     public function checkemty()
     {
         return Cart::instance();
         
     }
}
