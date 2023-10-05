<?php

namespace Modules\Testimonial\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Testimonial\Entities\Testimonial;

class TestimonialDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        factory(Testimonial::class, 10)->create();
    }
}
