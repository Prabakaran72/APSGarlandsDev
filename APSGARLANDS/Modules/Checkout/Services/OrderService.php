<?php

namespace Modules\Checkout\Services;

use Modules\Cart\CartTax;
use Modules\Cart\CartItem;
use Modules\Cart\Facades\Cart;
use Modules\Order\Entities\Order;
use Modules\Address\Entities\Address;
use Modules\FlashSale\Entities\FlashSale;
use Modules\Currency\Entities\CurrencyRate;
use Modules\Address\Entities\DefaultAddress;
use Modules\Shipping\Facades\ShippingMethod;
use Illuminate\Support\Facades\Session;
use Modules\Recurring\Entities\Recurring;
use Modules\Recurring\Entities\recurringSubOrder;

use Modules\Rewardpoints\Entities\Rewardpoints;
use Modules\RewardpointsGift\Entities\CustomerRewardPoint;
use Illuminate\Support\Carbon;

class OrderService
{
    public function create($request)
    {
        $this->mergeShippingAddress($request);
        $this->saveAddress($request);
        $this->addShippingMethodToCart($request);

        return tap($this->store($request), function ($order) {
            $this->storeOrderProducts($order);
            $this->storeOrderDownloads($order);
            $this->storeFlashSaleProductOrders($order);
            $this->incrementCouponUsage($order);
            $this->attachTaxes($order);
            $this->reduceStock();
        });
    }

    private function mergeShippingAddress($request)
    {
        $request->merge([
            'shipping' => $request->ship_to_a_different_address ? $request->shipping : $request->billing,
        ]);
    }

    private function saveAddress($request)
    {
        if (auth()->guest()) {
            return;
        }

        if ($request->newBillingAddress) {
            $address = auth()
                ->user()
                ->addresses()
                ->create($this->extractAddress($request->billing));

            $this->makeDefaultAddress($address);
        }

        if ($request->ship_to_a_different_address && $request->newShippingAddress) {
            auth()
                ->user()
                ->addresses()
                ->create($this->extractAddress($request->shipping));
        }
    }

    private function extractAddress($data)
    {
        return [
            'first_name' => $data['first_name'],
            'last_name' => $data['last_name'],
            'address_1' => $data['address_1'],
            'address_2' => $data['address_2'] ?? null,
            'city' => $data['city'],
            'state' => $data['state'],
            'zip' => $data['zip'],
            'country' => $data['country'],
        ];
    }

    private function makeDefaultAddress(Address $address)
    {
        if (
            auth()
            ->user()
            ->addresses()
            ->count() > 1
        ) {
            return;
        }

        DefaultAddress::create([
            'address_id' => $address->id,
            'customer_id' => auth()->id(),
        ]);
    }

    private function addShippingMethodToCart($request)
    {
        if (!Cart::allItemsAreVirtual() && !Cart::hasShippingMethod()) {
            Cart::addShippingMethod(ShippingMethod::get($request->shipping_method));
        }
    }

    private function store($request)
    {
        //GET RECURRING DETAILS
        $recurring_selected_date_count = $request->recurring_selected_date_count;
        $recurring_format_order_dates = $request->recurring_format_order_dates;
        $maxPreparingDays = $request->maxPreparingDays;
        $recurring_time = $request->recurring_time;

        $shippingMethod = Cart::shippingMethod()->name();
        $shippingCost = Cart::shippingCost()->amount();
        $shippingMethod = $request->shipping_method;

        // Check if the selected shipping method is 'local pickup'
        if ($shippingMethod === 'local_pickup') {
            // Use the selected pickup store details as the shipping address
            $shippingAddress = $request->selectedPickupstoreDetails;
        } else {
            // Use the regular shipping address details
            $shippingAddress = $request->shipping;
        }

        //Insert customer claimed rewardpoints in customer_reward_points table
        //Have to ensure customer has enough valid reward points

        $sessionRedeemedpoints = session('sessionRedeemedpoints', 0);

        if ($sessionRedeemedpoints > 0) {
            $customer_rewards_id = CustomerRewardPoint::insertGetId([
                'customer_id' =>  auth()->id(),
                'reward_points_claimed' => $sessionRedeemedpoints,
                'created_at' => date('Y-m-d H:i:s'),
                'updated_at' => date('Y-m-d H:i:s'),
            ]);
        }

        $reward_amount = isset($customer_rewards_id) ? $request->redemptionRewardAmount['amount'] : 0;
        // Calculate the total by adding the subTotal, discount, and shippingCost
        $total = Cart::subTotal()->amount() - Cart::discount()->amount() + $shippingCost - $reward_amount;

        $subTotal = (Cart::subTotal()->amount());
        $discount = (Cart::discount()->amount());

        //Recurring Order - Amount Calculation
        if ($recurring_selected_date_count > 0) {
            $isRecurring = 1;
        } else {
            $isRecurring = 0;
        }

        $createOrder =  Order::create([
            'customer_id' => auth()->id(),
            'customer_email' => $request->customer_email,
            'customer_phone' => $request->customer_phone,
            'customer_first_name' => $request->billing['first_name'],
            'customer_last_name' => $request->billing['last_name'],
            'billing_first_name' => $request->billing['first_name'],
            'billing_last_name' => $request->billing['last_name'],
            'billing_address_1' => $request->billing['address_1'],
            'billing_address_2' => $request->billing['address_2'] ?? null,
            'billing_city' => $request->billing['city'],
            'billing_state' => $request->billing['state'],
            'billing_zip' => $request->billing['zip'],
            'billing_country' => $request->billing['country'],
            'shipping_first_name' => $request->shipping['first_name'],
            'shipping_last_name' => $request->shipping['last_name'],
            'shipping_address_1' => $request->shipping['address_1'],
            'shipping_address_2' => $request->shipping['address_2'] ?? null,
            'shipping_city' => $request->shipping['city'],
            'shipping_state' => $request->shipping['state'],
            'shipping_zip' => $request->shipping['zip'],
            'shipping_country' => $request->shipping['country'],
            'sub_total' => Cart::subTotal()->amount(),
            'shipping_method' => Cart::shippingMethod()->name(),
            'shipping_cost' => $shippingCost,
            'coupon_id' => Cart::coupon()->id(),
            'discount' => Cart::discount()->amount(),
            'total' => $total, // Use the calculated total
            'payment_method' => $request->payment_method,
            'currency' => currency(),
            'currency_rate' => CurrencyRate::for(currency()),
            'locale' => locale(),
            'status' => Order::PENDING_PAYMENT,
            // 'note' => $request->order_note,
            'note' => $sessionRedeemedpoints,
            'rewardpoints_id' => isset($customer_rewards_id) ? $customer_rewards_id : null,
            'redemption_amount' => isset($customer_rewards_id) ? $request->redemptionRewardAmount['amount'] : null,
            'isRecurring' => $isRecurring,
        ]);

        //STORE THE RECURRING DETAILS IN THE RECURRING TABLE
        if ($recurring_selected_date_count > 0) {
            $recurringDateArray = explode(', ', $recurring_format_order_dates);
            // Create a Recurring record
            $recurring = Recurring::create([
                'order_id' => $createOrder->id,
                'recurring_date_count' => $recurring_selected_date_count,
                'max_preparing_days' => $maxPreparingDays,
                'delivery_time' => $recurring_time,
            ]);

            // Iterate over the date array and create recurringSubOrder records for each date
            foreach ($recurringDateArray as $date) {
                recurringSubOrder::create([
                    'recurring_id' => $recurring->id, // Use the ID of the newly created Recurring record
                    'selected_date' => $date,
                    'subscribe_status' => '1',
                    'order_status' => Order::PENDING,
                    'updated_user_id' => null,
                ]);
            }
        }
        return $createOrder;
    }


    private function storeOrderProducts(Order $order)
    {
        Cart::items()->each(function (CartItem $cartItem) use ($order) {
            $order->storeProducts($cartItem);
        });
    }

    private function storeOrderDownloads(Order $order)
    {
        Cart::items()->each(function (CartItem $cartItem) use ($order) {
            $order->storeDownloads($cartItem);
        });
    }

    private function storeFlashSaleProductOrders(Order $order)
    {
        Cart::items()->each(function (CartItem $cartItem) use ($order) {
            if (!FlashSale::contains($cartItem->product)) {
                return;
            }

            FlashSale::pivot($cartItem->product)
                ->orders()
                ->attach([
                    $cartItem->product->id => [
                        'order_id' => $order->id,
                        'qty' => $cartItem->qty,
                    ],
                ]);
        });
    }

    private function incrementCouponUsage()
    {
        Cart::coupon()->usedOnce();
    }

    private function attachTaxes(Order $order)
    {
        Cart::taxes()->each(function (CartTax $cartTax) use ($order) {
            $order->attachTax($cartTax);
        });
    }

    public function reduceStock()
    {
        Cart::reduceStock();
    }

    public function delete(Order $order)
    {
        $order->delete();

        Cart::restoreStock();
    }
}
