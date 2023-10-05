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
        Schema::create('reward_points_gifted', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('user_id')->index();
            // $table->string('customer_first_name','100')->index();
            // $table->string('customer_last_name','100')->index();
            // $table->string('email','100')->index();
            $table->integer('reward_point_value')->index()->nullable()->default(0);
            $table->string('reward_point_remarks','100')->index()->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('reward_points_gifted');
    }
};
