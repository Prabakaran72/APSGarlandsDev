<?php

use Modules\Blogtag\Entities\Blogtag;

$factory->define(Blogtag::class, function (Faker\Generator $faker) {
    return [
        'tag_name' => $faker->name(),
        'tag_code' => $faker->randomNumber(3),
        'description' => $faker->text(10),
    ];
});
