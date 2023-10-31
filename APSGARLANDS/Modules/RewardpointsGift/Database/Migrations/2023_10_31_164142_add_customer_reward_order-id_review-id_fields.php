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
        Schema::table('customer_reward_points', function (Blueprint $table) {
            $table->integer('order_id')->after('reward_type')->unsigned()->nullable();
            $table->integer('review_id')->after('order_id')->unsigned()->nullable();
            //##  'birthday' => not worked (null)
            //## 'signup' =>Default value is customer_id (null)
            //## 'firstorder' =>  orders.id
            //## 'firstpayment' => transactions.id
            //## 'firstreview' => reviews.id
            //## 'manualoffer' => (null)
            $table->foreign('order_id')->references('id')->on('orders')->onDelete('Cascade')->onUpdate('Noaction');
            $table->foreign('review_id')->references('id')->on('reviews')->onDelete('Cascade')->onUpdate('Noaction');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('customer_reward_points', function (Blueprint $table) {
            $table->integer('order_id');
            $table->integer('review_id');
        });
    }
};
