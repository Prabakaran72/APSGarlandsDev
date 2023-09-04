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
        Schema::create('recurring_order',function(Blueprint $table){
            $table->increments('id');
            $table->integer('order_id');
            $table->integer('customer_id');
            $table->string('recurring_frequency');
            $table->string('recurring_day');
            $table->date('recurring_date');
            $table->date('recurring_start_date');
            $table->date('recurring_end_date');
            $table->time('recurring_time');
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
        //
    }
};
