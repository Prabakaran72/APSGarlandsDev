<?php

//This seeder file only runs for the new table because the data is manually added and depends on the Recurring Main table

namespace Modules\Recurring\Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Modules\Order\Entities\Order;
use Modules\Recurring\Entities\Recurring;
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
        // Create an array of 5 dates
        $orderDates = [];

        // Get the current date
        $currentDate = Carbon::now();

        // Add the past 2 days
        for ($i = 2; $i > 0; $i--) {
            $orderDates[] = $currentDate->subDays($i)->toDateString();
        }

        // Add the current date
        $orderDates[] = $currentDate->toDateString();

        // Reset the date to the current date
        $currentDate = Carbon::now();

        // Add the future 2 days
        for ($i = 1; $i <= 2; $i++) {
            $orderDates[] = $currentDate->addDays($i)->toDateString();
        }

        // Insert records into the 'recurring_sub_orders' table
        foreach ($orderDates as $date) {
            DB::table('recurring_sub_orders')->insert([
                'recurring_id' => Recurring::all()->random()->id,
                'selected_date' => $date,
                'status' => '1',
                'updated_user_id' => User::all()->random()->id,
            ]);
        }
    }
}
