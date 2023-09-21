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
        Schema::create('recurring_sub_orders', function (Blueprint $table) {
            $table->integer('recurring_id')->unsigned();
            $table->integer('order_id')->unsigned();
            $table->date('order_date');
            $table->date('delivery_date');
            $table->integer('status');
            $table->integer('updated_user_id')->nullable();
            $table->timestamps();

            $table->foreign('recurring_id')->references('id')->on('recurring_main_orders')->onDelete('cascade');
            $table->foreign('order_id')->references('id')->on('orders')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('recurring_sub_orders');
    }
};
