<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        
            DB::unprepared("
            CREATE PROCEDURE CustomerActiveRewardPoint()
            BEGIN
               
            SELECT customer_id,earned_total FROM(SELECT * FROM (SELECT *,IF(customer_change!=0,@e:=0,IF(current_status=0,@e:=@e+1,@e:=@e+0)) as chk,IF(customer_change!=0,@d:=1,IF(current_status=0 OR @e!=0,@d:=0,@d:=@d+1)) as checking FROM (SELECT customer_id,IF(reward_points_earned!='',DATE_FORMAT(expiry_date,'%Y-%m-%d'),DATE_FORMAT(created_at,'%Y-%m-%d')) as entry_date,IFNULL(reward_points_earned,0) as reward,IFNULL(reward_points_claimed,0) as claimed,IF(@a=customer_id OR @a=0,@b:=@b+IFNULL(reward_points_earned,0)-IFNULL(reward_points_claimed,0),@b:=IFNULL(reward_points_earned,0)) as earned_total,IF(customer_id!=@a,@a:=customer_id,0) as customer_change,IF(DATE_FORMAT(expiry_date,'%Y-%m-%d')>='2023-10-09' OR IFNULL(reward_points_earned,0)=0,1,0) as current_status FROM customer_reward_points,(SELECT @a:=0) s,(SELECT @b:=0) t ORDER BY customer_id ASC,entry_date DESC) s, (SELECT @d:=0) t, (SELECT @e:=0) u) s ORDER by customer_id ASC, checking DESC) t GROUP by customer_id);

            END");
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        DB::unprepared('DROP PROCEDURE IF EXISTS CustomerActiveRewardPoint');
    }
};
