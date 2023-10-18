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
use Modules\Cart\Entities\UserCart;
use Modules\Cart\Entities\CartProduct;
use Modules\Cart\Entities\CartProductOption;
use Modules\Cart\Entities\CartProductOptionValue;

//use Modules\Product\Entities\Product;

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
        if (!empty((auth()->user()))) {
            $customer_id = auth()->user()->id;
            $first_name = auth()->user()->first_name;
            $last_name = auth()->user()->last_name;
        } else {
            $customer_id = '0';
            $first_name = '';
            $last_name = '';
        }
        
        $options = $request->options ?? [];
           
        $option = array_key_first($options);

        if($option == null)
           $option_id = 0;
        else
            $option_id = $option;
       
        $slug_val = $request->product_name;
        $product_id_val = $request->product_id;
        $qty = $request->qty;
        
        //$reason_destroy = "";    
       
        $UserCartSelect = UserCart::where([            
            'customer_id' => $customer_id,                
        ])->get();
        
        $UserCartCount = $UserCartSelect->count();

        if($UserCartCount==0)
        {
            $UserCartInsertId = UserCart::insertGetId([      
                'customer_id' => $customer_id,
                          
            ]);
           $cart_id = $UserCartInsertId; 
           //$cart_id = 1;
        }
        else{
            $UserCartList = UserCart::where([
                'customer_id' => $customer_id,
                      
         ])->first();
            $cart_id       = $UserCartList->id;
          // $cart_id       = 1;
        }
        //dd( $UserCartList->id);

        

        $CartProductSelect = CartProduct::where([            
            'cart_id' => $cart_id,  
            'product_id' => $product_id_val,
            'option_id' => $option_id,
            'deleted_at' => NULL,               
        ])->get();

            $CartProductCount = $CartProductSelect->count();
            
            
            if($CartProductCount==0)
            {
            $CartProductInsertId = CartProduct::insertGetId([               
                'qty' => $qty,               
                'cart_id' => $cart_id, 
                'product_id' => $product_id_val,
                'option_id' => $option_id,
            ]);
           
           $cart_products_id = $CartProductInsertId;          

           
            if (count($options) != '0')
            {
                
            if (count($options) == count($options, COUNT_RECURSIVE)) 
            {
                
                 //$demo = 'array is not multidimensional';
                 $option = array_key_first($options);
                 $option_value = $options[$option];

                 $CartProductInsert = CartProductOptionsValue::insert([               
                    'cart_product_id' => $cart_products_id,               
                    'option_value_id' => $option_value, 
                   
                ]);

            }
            else
            {
                //$demo = 'array is multidimensional';
                //print_r($options);
                //exit;
                $keys = array_keys($options);
		    for($i = 0; $i < count($options); $i++) {
		   
		    foreach($options[$keys[$i]] as $key => $value) {
		         //dd($value) ;
                 $CartProductInsert = CartProductOptionsValue::insert([               
                    'cart_product_id' => $cart_products_id,               
                    'option_value_id' => $value, 
                   
                ]);
		    }
		   
		}
            }
            
            }
            else{
                $demo = "array 0 Count";
                $option = 0;
            }
           // dd($option);
        }
        else{

            $CartProductList = CartProduct::where([
                'cart_id' => $cart_id, 
                'product_id' => $product_id_val,
                'option_id' => $option_id,
                'deleted_at' => NULL,          
         ])->first();
    
            $last_qty       = $CartProductList->qty;
            //$last_qty       = 1;
            $re_qty         = $qty+$last_qty;
            CartProduct::
            where([
                'cart_id' => $cart_id, 
                'product_id' => $product_id_val, 
                'option_id' => $option_id,
                'deleted_at' => NULL,           
         ])
            ->update(['qty' => $re_qty]);
        }


        
        Cart::store($request->product_id, $request->qty, $request->options ?? []);
      
       //Cart::instance();
      
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
        if (!empty((auth()->user()))) {
            $customer_id = auth()->user()->id;
            $first_name = auth()->user()->first_name;
            $last_name = auth()->user()->last_name;
        } else {
            $customer_id = '0';
            $first_name = '';
            $last_name = '';
        }      
        
        $qty = request('qty');
        $product_id = request('product_id');
        
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
        ->update(['qty' => $qty]);


        //AbandonedListModel::
        //where([
        //    'customer_id' => $customer_id,
        //    'product_id' => $product_id, 
        //    'deleted_at' => NULL,           
        //])
        //->update(['quantity' => $qty]);

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
        $cartItemRef    =   explode('##', $cartItemId);
        //DD($cartItemRef);
        //exit;
        $cart_item_id_val = $cartItemRef[0];
        $slug_val = $cartItemRef[1];
        $product_id_val = $cartItemRef[2];
        $qty = $cartItemRef[3];
        $unitprice = $cartItemRef[4];
        $reason_destroy = $cartItemRef[5];
         
       //Need Update Query

       //AbandonedListModel::
       //    where([
       //         'customer_id' => $customer_id,
       //         'product_id' => $product_id_val,
       //         'deleted_at' => NULL,           
      //   ])
       //     ->update(['reason' => $reason_destroy]);
        

      /*  $CartsAbandoned = AbandonedListModel::insert([
            'slug' => $slug_val,
            'quantity' => $qty,
            'rate' => $unitprice,
            'customer_id' => $customer_id,
            'product_id' => $product_id_val,
            'reason' => $reason_destroy,
            'first_name' => $first_name,
            'last_name' => $last_name,
           
        ]); */

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
            'product_id' => $product_id_val, 
            'option_id'  => $option_id,
            'deleted_at' => NULL,           
        ])
        ->update(['reason' => $reason_destroy]);

        
        CartProduct::where( ['cart_id' => $cart_id,
        'product_id' => $product_id_val,
        'option_id'  => $option_id,
        'deleted_at' => NULL, ] )->delete();

        Cart::remove($cart_item_id_val);
        //Cart::remove($cartItemId);
        return Cart::instance();
    }

    /*Get and Check */
    public function checkemty()
    {
		return Cart::instance();
		
    }
}
