<?php

namespace Modules\Cart\Http\Controllers;

use Modules\Cart\Facades\Cart;
use Modules\Cart\Entities\AbandonedListModel;

class CartClearController
{
    /**
     * Store a newly created resource in storage.
     *
     * @return \Illuminate\Http\Response
     */
    public function store()
    {

        
        if(auth()->check() && (auth()->user()->id)!=null){
            $customer_id=auth()->user()->id;
            $first_name=auth()->user()->first_name;
            $last_name=auth()->user()->last_name;
            $cartList=request('cartItemList');
            
            foreach($cartList as $cart_val){
                $cartItemRef    =   explode('@@@', $cart_val);
                $CartsAbandoned=AbandonedListModel::insert([
                    'slug'=>$cartItemRef[1],
                    'quantity'=>$cartItemRef[2],
                    'rate'=>$cartItemRef[3],
                    'customer_id'=>$customer_id,
                    'product_id'=>$cartItemRef[0],
                    'reason'=>request('reason_destroy'),
                    'first_name'=>$first_name,
                    'last_name'=>$last_name,
                ]);
            }
        }        
       Cart::clear();
       return Cart::instance();
    }
}
