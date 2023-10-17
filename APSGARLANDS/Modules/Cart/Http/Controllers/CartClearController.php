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
        if((auth()->user()->id)!=''){
            $customer_id=auth()->user()->id;
            $first_name=auth()->user()->first_name;
            $last_name=auth()->user()->last_name;
        }else{
            $customer_id='0'; 
            $first_name='';
            $last_name='';
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
    
            $options = $request->options ?? [];
               
            $option = array_key_first($options);
        
            if($option == null)
                $option_id = 0;
            else
                $option_id = $option;
    
            CartProduct::
            where([
                'cart_id'    => $cart_id,
                'product_id' => $product_id, 
                'option_id'  => $option_id,
                'deleted_at' => NULL,           
            ])
            ->update(['reason' =>  $reason ]);

            CartProduct::where( ['cart_id' => $cart_id,
            'product_id' => $product_id,
            'option_id'  => $option_id,
            'deleted_at' => NULL, ] )->delete();


            //AbandonedListModel::
           // where([
           //     'customer_id' => $customer_id,
          //      'product_id' => $product_id,
          //      'deleted_at' => NULL,           
         //])
          //  ->update(['reason' =>  $reason ]);
            

         //   AbandonedListModel::where( ['customer_id' => $customer_id,
        //    'product_id' => $product_id,
        //    'deleted_at' => NULL]  )->delete();
           
           /* $CartsAbandoned=AbandonedListModel::insert([
                'slug'=>$cartItemRef[1],
                   'quantity'=>$cartItemRef[2],
                   'rate'=>$cartItemRef[3],
                   'customer_id'=>$customer_id,
                    'product_id'=>$cartItemRef[0],
                    'reason'=>request('reason_destroy'),
                    'first_name'=>$first_name,
                    'last_name'=>$last_name,
                   
                  ]); */
        }
       Cart::clear();
       return Cart::instance();
    }
}
