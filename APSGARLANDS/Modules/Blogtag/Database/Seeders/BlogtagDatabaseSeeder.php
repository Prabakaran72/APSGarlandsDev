<?php

namespace Modules\Blogtag\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Blogtag\Entities\Blogtag;

class BlogtagDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        factory(Blogtag::class, 10)->create();
    }
}
