<?php

//This seeder file only runs for the new table because the data is manually added without factory

namespace Modules\Recurring\Database\Seeders;

use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;
use Modules\Order\Entities\Order;
use Modules\User\Entities\User;

class RecurringTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Sample data for the recurrings table
        DB::table('recurrings')->insert([
            'order_id' => Order::all()->random()->id,
            'recurring_date_count' => '5',
            'max_preparing_days' => 1,
            'delivery_time' => '12:05:00',
            'created_at' => Carbon::yesterday(),
        ]);

        // Add more data as needed
    }
}
