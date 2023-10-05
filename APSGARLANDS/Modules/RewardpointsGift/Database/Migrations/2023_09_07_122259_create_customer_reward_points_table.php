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
        Schema::create('customer_reward_points', function (Blueprint $table) {
            $table->id();
            $table->integer('customer_id')->index();
            $table->enum('reward_type',['birthday, firstsignup, firstorder, firstpayment, firstreview, manualoffer']);
            $table->integer('reward_points_earned')->nullable();
            $table->integer('reward_points_claimed')->nullable();
            $table->dateTime('expiry_date');
            $table->softDeletes();
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
        Schema::dropIfExists('customer_reward_points');
    }
};
