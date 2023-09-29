<?php

namespace Modules\Blogpost\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Blogpost\Entities\Blogpost;

class BlogpostDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        factory(Blogpost::class, 10)->create();
    }
}
