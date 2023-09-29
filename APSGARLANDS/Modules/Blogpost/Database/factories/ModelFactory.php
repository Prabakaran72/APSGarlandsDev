<?php

use Modules\Blogpost\Entities\Blogpost;

$factory->define(Blogpost::class, function (Faker\Generator $faker) {
    return [
        'post_title' => $faker->name(),
        'post_body' => $faker->randomNumber(3),
        'category_id' => '1',
        'tag_id' => '1',
        'author_id' => '1',
        'approved_by' => $faker->numberBetween(1, 10),
        'approved_date' => $faker->date(),

    ];
});
