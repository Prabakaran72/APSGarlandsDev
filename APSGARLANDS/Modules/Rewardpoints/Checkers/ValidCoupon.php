<?php

namespace Modules\Rewardpoints\Checkers;

use Closure;
use Modules\Rewardpoints\Exceptions\InvalidRewardpointsException;

class ValidRewardpoints
{
    public function handle($rewardpoints, Closure $next)
    {
        if ($rewardpoints->invalid()) {
            throw new InvalidRewardpointsException;
        }

        return $next($rewardpoints);
    }
}
