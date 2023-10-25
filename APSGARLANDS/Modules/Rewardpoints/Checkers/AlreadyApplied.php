<?php

namespace Modules\Rewardpoints\Checkers;

use Closure;
use Modules\Cart\Facades\Cart;
use Modules\Rewardpoints\Exceptions\RewardpointsAlreadyAppliedException;

class AlreadyApplied
{
    public function handle($coupon, Closure $next)
    {
        if (Cart::couponAlreadyApplied($coupon)) {
            throw new RewardpointsAlreadyAppliedException;
        }

        return $next($coupon);
    }
}
