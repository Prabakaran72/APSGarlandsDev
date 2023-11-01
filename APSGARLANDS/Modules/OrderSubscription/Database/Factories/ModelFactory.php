<?php

use Modules\OrderSubscription\Entities\OrderSubscription;

$factory->define(OrderSubscription::class, function (Faker\Generator $faker) {
    return [
        'name' => $faker->word(),
        'slug' => $faker->slug(),
        'on_navigation' => $faker->boolean(),
        'is_active' => $faker->boolean(),
    ];
});
