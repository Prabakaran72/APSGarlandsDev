<?php

//This seeder file only runs for the new table because the data is manually added and depends on the Recurring Main table

namespace Modules\Recurring\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Modules\Order\Entities\Order;
use Modules\User\Entities\User;

class RecurringSubOrderTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        // Sample data for the recurring_sub_orders table
        DB::table('recurring_sub_orders')->insert([
            'recurring_id' => 1,
            'order_id' => Order::all()->random()->id,
            'selected_date' => Carbon::now()->toDateString(),
            'delivery_date' => Carbon::tomorrow()->toDateString(),
            'is_active' => '1',
            'updated_user_id' => User::all()->random()->id,
            // 'created_at' => now(),
            'updated_at' => now(),
        ]);

        // Add more data as needed
    }
}
