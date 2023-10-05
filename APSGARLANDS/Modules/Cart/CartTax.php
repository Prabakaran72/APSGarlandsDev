<?php

namespace Modules\Cart;

use JsonSerializable;
use Modules\Support\Money;

class CartTax implements JsonSerializable
{
    private $cart;
    private $taxRate;
    private $taxCondition;

    public function __construct($cart, $taxRate, $taxCondition)
    {
        $this->cart = $cart;
        $this->taxRate = $taxRate;
        $this->taxCondition = $taxCondition;
    }

    public function id()
    {
        return $this->taxRate->id;
    }

    public function name()
    {
        return $this->taxRate->name;
    }

    public function amount()
    {
        return Money::inDefaultCurrency($this->calculate());
    }

    private function calculate()
    {
        return $this->taxCondition->getCalculatedValue($this->productsTotalPrice());
    }

    private function productsTotalPrice()
    {
        return $this->taxApplicableProducts()->sum(function ($cartItem) {
            return $cartItem->total()->amount();
        });
    }

    public function toArray()
    {
        return [
            'name' => $this->name(),
            'amount' => $this->amount(),
        ];
    }

    public function jsonSerialize()
    {
        return $this->toArray();
    }

    public function __toString()
    {
        return json_encode($this->jsonSerialize());
    }
}
