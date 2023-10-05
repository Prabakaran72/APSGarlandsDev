<?php

use Illuminate\Database\Eloquent\Factories\Factory;
use Modules\Pickupstore\Entities\Pickupstore;



$factory->define(Pickupstore::class, function (Faker\Generator $faker) {
        $name = ['Aishah', 'Ahmad', 'Zara','Rayyan', 'Muhammad'  ];
        $email = ['Aishah@gmail.com', 'Ahmad@gmail.com', 'Zara@gmail.com','Rayyan@gmail.com', 'Muhammad@gmail.com' ];
        $phone=['60-16-9639865','60-16-7864512','60-16-4567894','60-16-7894564','60-16-124581'];
        $city=['Kuala Lumpur','Johor Bahru','Penang',' Selangor','Terengganu'];
        $state=['KUL','JHR','PNG','SGR','TRG'];
        $selectedCity = $faker->randomElement($city);
        $country=['MY'];

return [
    'name' => $faker->randomElement($name),
    'tagline' => $faker->catchPhrase,
    'email' => $faker->randomElement($email),
    'phone' => '60-16-'.$faker->numberBetween(124500, 9999999),
    'address_1' => $faker->streetAddress,
    'address_2' => $faker->secondaryAddress,
    'city' => $selectedCity,
    'store_state'=> $faker->randomElement($state),
    'store_country'=> $faker->randomElement($country),
    'zip'=> $faker->unique()->numberBetween(59000, 59009),
    'is_active'=> $faker->boolean(),
    
];

});

