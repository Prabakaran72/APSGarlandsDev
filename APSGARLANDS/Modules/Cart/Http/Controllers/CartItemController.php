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

    /**
     * Remove the specified resource from storage.
     *
     * @param string $cartItemId
     * @return \Illuminhtate\Http\Response
     */
    public function destroy($cartItemId)
    {
        if (!empty((auth()->user()))) {
            $customer_id = auth()->user()->id;
            $first_name = auth()->user()->first_name;
            $last_name = auth()->user()->last_name;
        } else {
            $customer_id = '0';
            $first_name = '';
            $last_name = '';
        }
        $cartItemRef    =   explode('$$##$$', $cartItemId);
        $cart_item_id_val = $cartItemRef[0];
        $slug_val = $cartItemRef[1];
        $product_id_val = $cartItemRef[2];
        $qty = $cartItemRef[3];
        $unitprice = $cartItemRef[4];
        $reason_destroy = $cartItemRef[5];

        $CartsAbandoned = AbandonedListModel::insert([
            'slug' => $slug_val,
            'quantity' => $qty,
            'rate' => $unitprice,
            'customer_id' => $customer_id,
            'product_id' => $product_id_val,
            'reason' => $reason_destroy,
            'first_name' => $first_name,
            'last_name' => $last_name,
        ]);

        Cart::remove($cart_item_id_val);

        return Cart::instance();
    }
}
