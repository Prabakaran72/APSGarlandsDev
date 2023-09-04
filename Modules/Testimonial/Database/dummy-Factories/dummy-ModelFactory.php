<?php

use Modules\Testimonial\Entities\Testimonial;

$factory->define(Testimonial::class, function (Faker\Generator $faker) {
    return [
        'name' => $faker->word(),
        'code' => $faker->word(),
        'value' => $faker->randomNumber(),
        'is_percent' => $faker->boolean(),
        'is_active' => $faker->boolean(),
    ];
});
