<?php

namespace Modules\Fixedrate\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Fixedrate\Entities\Fixedrate;

class FixedrateDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
      

        factory(Fixedrate::class, 5)->create();
    }
}
