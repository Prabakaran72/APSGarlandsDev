<?php

namespace Modules\Cart\Http\Controllers;

use Modules\Cart\Facades\Cart;
use Modules\Cart\Entities\AbandonedListModel;
use Modules\Cart\Entities\UserCart;
use Modules\Cart\Entities\CartProduct;
use Modules\Cart\Entities\CartProductOptionsValue;

class CartClearController
{
    /**
     * Store a newly created resource in storage.
     *
     * @return \Illuminate\Http\Response
     */
    public function store()
    {
        if (auth()->check()) {
            $customer_id=auth()->user()->id;
           
        }else{
            $customer_id='0';
        }
        $cart=request('cartItemListNewArray');
        foreach($cart as $cart_val){
            $cartItemRef    =   explode('@@@', $cart_val);
            $product_id     =   $cartItemRef[0];
            $reason         =   request('reason_destroy');
            $UserCartList = UserCart::where([
                'customer_id' => $customer_id,
            ])->first();
                $cart_id       = $UserCartList->id;
            CartProduct::
            where([
                'cart_id'    => $cart_id,
                'product_id' => $product_id,
                'deleted_at' => NULL,
            ])
            ->update(['reason' =>  $reason ,'deleted_at'=>now(),'customer_id' => $customer_id]);
        }
       Cart::clear();
       return Cart::instance();
    }
}
