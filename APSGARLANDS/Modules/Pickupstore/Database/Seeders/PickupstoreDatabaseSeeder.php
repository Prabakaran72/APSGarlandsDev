<?php

namespace Modules\Pickupstore\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Pickupstore\Entities\Pickupstore;
use Carbon\Carbon;

class PickupstoreDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Pickupstore::insert([
            [
                'first_name' =>'APS Main',
                'tagline' => 'Grab Your Orders Here!',
                'email' => 'Aishah@gmail.com',
                'phone' => '6090302050',
                'address_1' => 'Kuala Lumpur',
                'address_2' => 'Kuala Lumpur',
                'city' => 'Kuala Lumpur',
                'state'=> 'KUL',
                'country'=> 'MY',
                'zip'=> '59000',
                'is_active'=> 1,
                'created_at' => Carbon::now(),
            ],
            [
                'first_name' =>'APS Selangor',
                'tagline' => 'Grab Your Orders Here!',
                'email' => 'Ahmad@gmail.com',
                'phone' => '6090302051',
                'address_1' => 'Selangorr',
                'address_2' => 'Selangor',
                'city' => 'Selangor',
                'state'=> 'SGR',
                'country'=> 'MY',
                'zip'=> '59001',
                'is_active'=> 1,
                'created_at' => Carbon::now(),
            ],
            [
               
                'first_name' =>'APS JHR',
                'tagline' => 'Grab Your Orders Here!',
                'email' => 'Zara@gmail.com',
                'phone' => '6090302055',
                'address_1' => 'Johor Bahru',
                'address_2' => 'Johor Bahru',
                'city' => 'Johor Bahru',
                'state'=> 'JHR',
                'country'=> 'MY',
                'zip'=> '59002',
                'is_active'=> 1,
                'created_at' => Carbon::now(),
            ],
            [
                
                'first_name' =>'APS Penang',
                'tagline' => 'Grab Your Orders Here!',
                'email' => 'Rayyan@gmail.com',
                'phone' => '6090302061',
                'address_1' => 'Penang',
                'address_2' => 'Penang',
                'city' => 'Penang',
                'state'=> 'PNG',
                'country'=> 'MY',
                'zip'=> '59006',
                'is_active'=> 1,
                'created_at' => Carbon::now(),
            ],
        ]);
        
    }
}
