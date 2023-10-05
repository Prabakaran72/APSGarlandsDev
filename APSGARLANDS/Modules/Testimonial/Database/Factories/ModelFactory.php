<?php

use Modules\Testimonial\Entities\Testimonial;
use Modules\User\Entities\User;

$factory->define(Testimonial::class, function (Faker\Generator $faker) {
    return [
        'user_id' => User::all()->random()->id,
        'user_name' => $faker->name(),
        'comment' => $faker->text(),
        'is_active' => $faker->boolean(),
    ];
});
