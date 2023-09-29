<?php

namespace Modules\Blogcategory\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Blogcategory\Entities\Blogcategory;

class BlogcategoryDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        factory(Blogcategory::class, 10)->create();
    }
}
