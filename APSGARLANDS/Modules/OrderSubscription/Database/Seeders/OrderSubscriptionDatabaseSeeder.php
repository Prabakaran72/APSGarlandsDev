<?php

namespace Modules\OrderSubscription\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\OrderSubscription\Entities\OrderSubscription;

class OrderSubscriptionDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        factory(OrderSubscription::class, 20)->create();
    }
}
