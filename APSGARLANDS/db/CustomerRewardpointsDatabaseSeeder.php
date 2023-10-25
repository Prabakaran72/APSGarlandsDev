<?php

namespace Modules\RewardpointsGift\Database\Seeders;

use Illuminate\Database\Seeder;

use Modules\RewardpointsGift\Entities\CustomerRewardPoint;

class CustomerRewardpointsDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {        
        factory(CustomerRewardPoint::class, 30)->create();
        // CustomerRewardPoint::factory()->count(30)->create();

        // $this->call("OthersTableSeeder");


    }
}
