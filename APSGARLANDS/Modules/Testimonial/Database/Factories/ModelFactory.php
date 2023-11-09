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
    // return [
    //     'user_id' => \App\Models\User::all()->random()->id,
    //     'user_name' => $this->faker->name,
    //     'comment' => $this->faker->text,
    //     'is_active' => $this->faker->randomElement([0, 1]),
    //     'created_at' => now(), // Default date
    // ];
});
