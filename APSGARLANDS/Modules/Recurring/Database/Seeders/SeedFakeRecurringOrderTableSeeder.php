<?php

namespace Modules\Recurring\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Modules\Recurring\Entities\Recurring;
use Illuminate\Support\Facades\DB;
use Faker\Factory as Faker;
use Illuminate\Support\Carbon;

class SeedFakeRecurringOrderTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $faker = Faker::create();
        foreach (range(1, 10) as $index) {
            DB::table('recurrings')->insert([
                'customer_id' => $faker->numberBetween(1, 100),
                'recurring_delivery_time' => $faker->time, // Use $faker->time for a random time string
                'created_at' => Carbon::now(), // Use Carbon to get the current datetime
            ]);
        }
    }
}
