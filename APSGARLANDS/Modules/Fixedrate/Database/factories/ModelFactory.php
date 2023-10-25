<?php


use Illuminate\Database\Eloquent\Factories\Factory;
use Modules\Fixedrate\Entities\Fixedrate;



$factory->define(Fixedrate::class, function (Faker\Generator $faker) {
// $pincodes = ['59000', '59002', '59003','59004', '59005'  ];
// $flatPrices = [20, 25, 30,40,50  ];

return [
    'pincode' => $faker->unique()->numberBetween(59000, 59009),
    'flat_price' => $faker->numberBetween(20,30),
    'is_active' => $faker->boolean(),
];
   
});



