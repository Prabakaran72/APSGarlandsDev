<?php

namespace Modules\Order\Http\Controllers\Admin;

use Modules\Order\Entities\Order;
use Modules\Order\Entities\OrderProduct;
use Modules\Admin\Traits\HasCrudActions;
use Modules\User\Entities\User;
// use Modules\Customer\Entities\Customer;
use Illuminate\Support\Carbon;
use Modules\Support\Country;
use Modules\Support\State;
use Modules\Product\Entities\Product;
use Illuminate\Http\Request;
use Modules\Coupon\Entities\Coupon;
use Modules\Shipping\Facades\ShippingMethod;
use Modules\Support\Money;
use Modules\Currency\Entities\CurrencyRate;
use Modules\Address\Entities\DefaultAddress;



class OrderController
{
    use HasCrudActions;

    /**
     * Model for the resource.
     *
     * @var string
     */
    protected $model = Order::class;

    /**
     * The relations to eager load on every query.
     *
     * @var array
     */
    protected $with = ['products', 'coupon'];

    /**
     * Label of the resource.
     *
     * @var string
     */
    protected $label = 'order::orders.order';

    /**
     * View path of the resource.
     *
     * @var string
     */
    protected $viewPath = 'order::admin.orders';

    public function create()
    {
        // $user = User::all(['id', 'first_name']);
        // $customer = Customer::all(['id','first_name']);
        // $users = $user->merge($customer);
        $user = User::all(['id', 'first_name','last_name'])->map(function ($user) {
            $user['ids'] .= 'L-'.$user['id'];
            $customer['fullname'] = $user['first_name'].' '.$user['last_name'];
            return $user;
        });
    
        // $customer = Customer::all(['id', 'first_name', 'last_name'])->map(function ($customer) {
        //     $customer['ids'] .= 'M-'.$customer['id'];
        //     $customer['fullname'] = $customer['first_name'].' '.$customer['last_name'];
        //     return $customer;
        // });
    
         $users = $user;
        $date = Carbon::now()->format('Y-m-d');

        $countries =   Country::all();
        
         $products = Product::select('id','slug','price','prepare_days','is_preorder_status','manage_stock','qty','in_stock')->get();

          $shippingMethods =  ShippingMethod::availableShippingMannual();
          $minimumAmount = Money::inDefaultCurrency(setting('free_shipping_min_amount'));   

        // $query = str_replace(array('?'), array('\'%s\''), $products->toSql());
        // $query = vsprintf($query, $products->getBindings());
        // return  response()->json(['user' => $users ]) ;
         return view("{$this->viewPath}.create", compact('users','date','countries','products','shippingMethods','minimumAmount'));
    }

    public function details($id){

        $string = $id;
        $parts = explode('-', $string); // Split the string at the hyphen
        $user_id = $parts[0];
        $ids = $parts[1];
        $data = array();

        if($user_id == 'L'){

            $user = User::findOrFail($ids);
            $addresses = $user->addresses;
            $defaultaddresses =  $user->defaultAddress ?? new DefaultAddress; 
            $data[] =  ['user' => $user,'address' => $addresses, 'type' => 'user', 'defaultaddresses' => $defaultaddresses];
        }
        else{

            // $data = Customer::findOrFail($ids);
            // $data['type'] ='mannual';
            // $data['state_name'] =$data->getUserStateNameAttribute();
            // $data['country_name'] =$data->getUserCountryNameAttribute();
           
           

        }
            return  response()->json([
            'data' => $data,
           ]);
    }


    public function store(Request $request){
        $countries = new  Country;
        $state = new State;
        $s_code = '';
        $data = $request->data; // Assuming $request->data is already an array or object
        $billingCountry = $countries->supportedCodes($data['billing_country']);
         $billingStates = $state->get($billingCountry[0]);
          foreach($billingStates as $stateCode =>$states){
            if($states === $data['billing_state']){
                $s_code =  $stateCode;
            }
        }
        $state_code = $s_code;
        $country = $billingCountry[0];
       $data['billing_country'] = $country;
       $data['billing_state'] = $state_code;
       $data['shipping_country'] = $country;
       $data['shipping_state'] = $state_code;
        $data['total'] =  Money::inDefaultCurrency($data['total']);
        $data['sub_total'] =  Money::inDefaultCurrency($data['sub_total']);
        $data['discount'] =  Money::inDefaultCurrency($data['discount']);
        $data['currency'] =  currency();
        $data['currency_rate'] = CurrencyRate::for(currency());
        $data['locale'] =  locale();
        $data['shipping_cost'] =  Money::inDefaultCurrency($data['shipping_cost']);



        $obj = new Order;
        $insert = $obj->create($data);
       
        if($insert->id){
            $products =  $request->product;
            $p = array();
        foreach($products as $product){
            $p[] = $product;
        }
        if(is_array($p)){
            foreach($p as &$product){
                $product['order_id'] = $insert->id;
                $product_obj = new OrderProduct;
                $insert_pro = $product_obj->create($product);
            }
            // Coupon::increment('used');
            // return response()->json([
            //     'data' => 'successpdata',
            //     'products' => $p
            // ]);

        }
        if($insert->coupon_id){
            Coupon::find($insert->coupon_id)->increment('used');
        }

        // foreach ($p as $product){
        //     $product_obj = new OrderProduct;
        //     $insert_pro = $product_obj->create($product);
        // }
            // // Check if $products is an array of objects
            // if (is_array($products)) {
            //     foreach ($products as &$product) {
            //         $product['order_id'] = $insert->id;
            //     }
            // } else {
            //     // If $products is a single object, add the 'order_id' to it
            //     $products['order_id'] = $insert->id;
            // }

            // foreach ($products as $product) {
            //     $product_obj = new OrderProduct;
            //     $insert_pro = $product_obj->create($product);
                
            // }

            
            
            return response()->json([
                'data' => 'success',
                'products' => $insert->coupon_id
            ]);
        }
        
        return response()->json([
            'status' =>'fail',
        ]);
        
        

        
    }


    function show($id){

        $order = Order::findOrFail($id);
        if( $order['user_type'] == 'Login'){

            $entity = $this->getEntity($id);

            if (request()->wantsJson()) {
                return $entity;
            }
    
            return view("{$this->viewPath}.show")->with($this->getResourceName(), $entity);

        }
        else if($order['user_type'] == 'Manual'){
            $entity = $this->getEntity($id);

            if (request()->wantsJson()) {
                return $entity;
            }

        //    dd($entity);
         $preff = 'M-';
            // return view("order::admin.orders.create")->with($this->getResourceName(), $entity , $preff);

            $products = Product::select('id','slug','price')->get();

            return view("order::admin.orders.create", [
                $this->getResourceName() => $entity,
                'preff' => $preff,
                'products' => $products,
            ]);

        }else{

            $entity = $this->getEntity($id);

            if (request()->wantsJson()) {
                return $entity;
            }
            
    
            return view("{$this->viewPath}.show")->with($this->getResourceName(), $entity);

        }

       

    }


    public function update(Request $request, $id)
    {

        $countries =new  Country;
        $state = new State;
        $s_code = '';
        $data = $request->data; // Assuming $request->data is already an array or object
        $billingCountry = $countries->supportedCodes($data['billing_country']);
         $billingStates = $state->get($billingCountry[0]);
          foreach($billingStates as $stateCode =>$states){
            if($states === $data['billing_state']){
                $s_code =  $stateCode;
            }
        }
        $state_code = $s_code;
        $country = $billingCountry[0];
       $data['billing_country'] = $country;
       $data['billing_state'] = $state_code;
       $data['shipping_country'] = $country;
       $data['shipping_state'] = $state_code;

  
            $order = Order::findOrFail($id);

            $order->update($data);

           
            if ($order->wasChanged()) {
                $products = $request->product;

              
                if (is_array($products)) {
                    foreach ($products as &$product) {
                        $product['order_id'] = $order->id;
                    }
                } else {
                    
                    $products['order_id'] = $order->id;
                }

              
                $order->products()->delete();

              
                $order->products()->createMany($products);

                return response()->json([
                    'data' => 'success',
                ]);
            }

            return response()->json([
                'status' => 'fail',
            ]);


    }


    public function coupontest(){
        return response()->json([
            'status' => 'test',
        ]);
    }

    


}
