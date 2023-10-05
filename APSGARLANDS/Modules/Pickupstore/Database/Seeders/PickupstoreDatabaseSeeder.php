<?php

namespace Modules\Pickupstore\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Pickupstore\Entities\Pickupstore;

class PickupstoreDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
      

        factory(Pickupstore::class, 5)->create();
    }
}
