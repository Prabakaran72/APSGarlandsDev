<?php

namespace Modules\Payment\Gateways;

use Illuminate\Http\Request;
use Modules\Order\Entities\Order;
use Modules\Payment\GatewayInterface;
use Modules\Payment\Responses\RazerpayResponse;

class Razerpay implements GatewayInterface
{
    public $label;
    public $description;

    public function __construct()
    {
        $this->label = setting('razerpay_label');
        $this->description = setting('razerpay_description');
        $this->instructions = setting('razerpay_instructions');
    }

    public function client()
    {
        $apiCreds   =   array('apiKey'  =>  setting('razerpay_key_id'),
                            'apiSecret' =>  setting('razerpay_key_secret'));
        return json_encode($apiCreds);
    }
    public function purchase(Order $order, Request $request)
    { 
        $redirectedurl = setting('razerpay_url');
        $amount = $order->total->convertToCurrentCurrency()->round()->amount();
        $merchantID = setting('razerpay_merchant_id'); // Replace with your actual merchant ID
        $oid = $order->id;
        $verifykey = setting('razerpay_key_secret'); // Replace with your actual verify key
        $url = $redirectedurl . $merchantID;
    
        $billingFirstName = $order->billing_first_name;
        $billingLastName = $order->billing_last_name;
        $billingEmail = $order->customer_email;
        $billingMobile = $order->customer_phone;
        $billingCountry = $order->billing_country;
        $billingName = $billingFirstName . ' ' . $billingLastName;
    
        // Calculate $vcode
        $vcode = md5($amount . $merchantID . $oid . $verifykey);
    
        // Create an associative array with the details
        $data = [
            'redirectedurl' => $redirectedurl,
            'amount' => $amount,
            'merchantID' => $merchantID,
            'oid' => $oid,
            'verifykey' => $verifykey,
            'url' => $url,
            'billingFirstName' => $billingFirstName,
            'billingLastName' => $billingLastName,
            'billingEmail' => $billingEmail,
            'billingMobile' => $billingMobile,
            'billingCountry' => $billingCountry,
            'billingName' => $billingName,
            'vcode' => $vcode,
        ];
    
        // Create a new RazerpayResponse with the order instance
        return new RazerpayResponse($order);
    }
    

    
    // public function purchase(Order $order, Request $request)
    // { dd( $request);
    //     $razerpayOrder = $this->client()->order->create([
    //         'receipt' => $order->id,
    //         'amount' => $order->total->convertToCurrentCurrency()->subunit(),
    //         'currency' => currency(),
    //         'payment_capture' => true,
    //     ]);
    //    // dd($razerpayOrder);
    
    //     return new RazerpayResponse($razerpayOrder);
    // }
    
    public function complete(Order $order)
    {
        /*$attributes = [
            'razerpay_payment_id' => request('razerpay_payment_id'),
            'razerpay_order_id' => request('razerpay_order_id'),
            'razerpay_signature' => request('razerpay_signature'),
        ];

        $this->client()->utility->verifyPaymentSignature($attributes);

        $razerpayOrder = new RazerpayOrder;
        $razerpayOrder->fill($attributes);

        return new RazerpayResponse($razerpayOrder);*/
    }
}
