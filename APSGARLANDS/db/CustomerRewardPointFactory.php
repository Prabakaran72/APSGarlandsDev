<?php

namespace Modules\RewardpointsGift\Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use Modules\User\Entities\User;
use Modules\Rewardpoints\Entities\Rewardpoints;
use Illuminate\Support\Arr;
use Carbon\Carbon;
use Faker\Generator as Faker;

class CustomerRewardPointFactory extends Factory
{
    /**
     * The name of the factory's corresponding model.
     *
     * @var string
     */
    protected $model = CustomerRewardPoint::class;

    /**
     * Define the model's default state.
     *
     * @return array
     */

    public function definition()
    {
        $type = ['birthday', 'firstsignup', 'firstorder', 'firstpayment', 'firstreview', 'manualoffer'];
        $user =  User::whereHas('user_roles', function ($query) {
            $query->where('role_id', '!=', 1); // Assuming role ID 1 represents the admin role
        });
        $exp= Carbon::now()->addDays(Rewardpoints::first()->add_days_reward_points_expiry);
        $re_ern = floor($this->faker->numberBetween(100, 5000)) / 10;
        return [
            'customer_id' => $user->id,
            'reward_type' => Arr::random($type),
            'reward_points_earned' => $re_ern,
            'claimed_reward_points' => $this->faker->boolean(20) ? ($this->faker->numberBetween(1, 50)) : null,
            'expiry_date' => $exp,
        ];
    }
}
