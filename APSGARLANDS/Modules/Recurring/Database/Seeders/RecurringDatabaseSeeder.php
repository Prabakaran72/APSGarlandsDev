<?php

namespace Modules\Recurring\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Recurring\Entities\Recurring;

class RecurringDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        factory(Recurring::class, 10)->create();
    }
}
