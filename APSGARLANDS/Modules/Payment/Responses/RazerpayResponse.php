<?php
namespace Modules\Payment\Responses;


use Modules\Order\Entities\Order;
use Modules\Payment\GatewayResponse;
use Modules\Payment\HasTransactionReference;

class  RazerpayResponse extends GatewayResponse implements HasTransactionReference
{
    private $order;

    public function __construct(Order $order)
    { 
       
        $this->order = $order;
    }

    public function getOrderId()
    {
        return $this->order->id;
    }

    public function getTransactionReference()
    {
        return request('reference');
    }

    public function toArray()
{  
    //  dd($this->order->total->convertToCurrentCurrency()->round()->amount());
    $vcode = md5($this->order->total->convertToCurrentCurrency()->round()->amount() . setting('razerpay_merchant_id') . $this->order->id . setting('razerpay_key_secret'));

    return [
        'key' => setting('razerpay_key_id'),
        'email' => $this->order->customer_email,
        'amount' => $this->order->total->convertToCurrentCurrency()->round()->amount(),
        'ref' => 'ref' . time(),
        'currency' => currency(),
        'orderid' => $this->order->id,
        'redirectedurl' => setting('razerpay_url').setting('razerpay_merchant_id'),
        'merchantID' => setting('razerpay_merchant_id'),
        'verifykey' => setting('razerpay_key_secret'),
        'billingFirstName' => $this->order->billing_first_name,
        'billingLastName' => $this->order->billing_last_name,
        'bill_email' => $this->order->customer_email,
        'bill_mobile' => $this->order->customer_phone,
        'country' => $this->order->billing_country,
        'bill_name' => $this->order->billing_first_name . ' ' . $this->order->billing_last_name,
        'vcode' => $vcode,
    ];
}

}