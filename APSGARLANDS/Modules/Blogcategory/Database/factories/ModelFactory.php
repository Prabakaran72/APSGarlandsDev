<?php

use Modules\Blogcategory\Entities\Blogcategory;

$factory->define(Blogcategory::class, function (Faker\Generator $faker) {
    return [
        'category_name' => $faker->name(),
        'category_code' => $faker->randomNumber(3),
        'description' => $faker->text(10),
    ];
});
