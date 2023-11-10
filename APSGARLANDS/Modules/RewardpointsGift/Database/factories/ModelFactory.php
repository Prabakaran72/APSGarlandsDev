<?php

namespace Modules\RewardpointsGift\Database\Factories;

use Modules\RewardpointsGift\Entities\CustomerRewardPoint;
use Modules\User\Entities\User;
use Modules\RewardpointsGift\Entities\RewardpointsGift;


use Modules\Rewardpoints\Entities\Rewardpoints;
use Illuminate\Support\Arr;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;


$type = ['birthday', 'firstsignup', 'firstorder', 'firstpayment', 'firstreview', 'manualoffer'];
$user1 = DB::table('users')
    ->join('user_roles', 'users.id', '=', 'user_roles.user_id')
    ->join('roles', 'user_roles.role_id', '=', 'roles.id')
    ->join('role_translations', 'roles.id', '=', 'role_translations.role_id')
    ->where('role_translations.name', '=', 'Customer')
    ->select('users.id')
    ->get();
$userIdsArray = $user1->pluck('id')->toArray();
$factory->define(CustomerRewardPoint::class, function ($faker) use ($type, $userIdsArray) {  
    $bool = $faker->boolean(70);
    return [
        'customer_id' =>Arr::random($userIdsArray),
        'reward_type' => $bool ? Arr::random($type) : null,
        'reward_points_earned' => $bool ? (floor($faker->numberBetween(100, 1000)) / 10) : null,
        'reward_points_claimed' => !$bool ? ($faker->numberBetween(1, 50)) : null,
        'expiry_date' => $bool ?((Carbon::now()->addDays(Rewardpoints::first()->add_days_reward_points_expiry))) : null
    ];
});

$factory->define(RewardpointsGift::class, function ($faker) use($userIdsArray) {
    return [
        'user_id'  => Arr::random($userIdsArray),
        'reward_point_value' => floor($faker->numberBetween(100, 1000)) / 10,
        'reward_point_remarks' => $faker->sentence,
        'customer_reward_id' => CustomerRewardPoint::all()->random()->id,
    ];
});
