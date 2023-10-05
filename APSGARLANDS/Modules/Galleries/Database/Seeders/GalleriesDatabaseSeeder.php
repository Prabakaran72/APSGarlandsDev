<?php

namespace Modules\Galleries\Database\Seeders;

use Illuminate\Database\Seeder;
use Modules\Galleries\Entities\Galleries;
use Carbon\Carbon;

class GalleriesDatabaseSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Galleries::insert([
            [
                
                'user_id' => 1,
                'videoID' => 'Rr3eUfVD-e4',
                'videoFullURL' => 'https://www.youtube.com/watch?v=Rr3eUfVD-e4',
                'videoTitle' => 'Medley พุ่มพวงในดวงใจ By Jennifer Kim',
                'channelTitle' => 'Bouquet P',
                'is_active' => 1,
                'created_at' => Carbon::now(),
            ],
            [
               
                'user_id' => 1,
                'videoID' => 'T-Z-VYrJYE8',
                'videoFullURL' => 'https://www.youtube.com/watch?v=T-Z-VYrJYE8',
                'videoTitle' => 'HBD PKai',
                'channelTitle' => 'Bouquet P',
                'is_active' => 1,
                'created_at' => Carbon::now(),
            ],
            [
               
                'user_id' => 1,
                'videoID' => 'OMYgrKqn4zw',
                'videoFullURL' => 'https://www.youtube.com/watch?v=OMYgrKqn4zw',
                'videoTitle' => 'Memory Of You By Mr.saxman',
                'channelTitle' => 'Bouquet P',
                'is_active' => 1,
                'created_at' => Carbon::now(),
            ],
            [
                
                'user_id' => 1,
                'videoID' => '_27-fp-LH_c',
                'videoFullURL' => 'https://www.youtube.com/watch?v=_27-fp-LH_c',
                'videoTitle' => 'I Will Survive By Jennifer Kim @Jsl Studio',
                'channelTitle' => 'Bouquet P',
                'is_active' => 1,
                'created_at' => Carbon::now(),
            ],
        ]);
        
    }
}
