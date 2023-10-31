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
        Schema::create('recurrings', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('order_id');
            $table->integer('recurring_date_count')->nullable();
            $table->integer('max_preparing_days')->nullable();
            $table->time('delivery_time');
            // $table->unsignedInteger('created_user_id');
            // $table->timestamp('created_at')->nullable();
            // Add foreign key constraint
            // $table->foreign('created_user_id','created_user_id')
            //     ->references('id')->on('users')
            //     ->onDelete('cascade')
            //     ->onUpdate('cascade');
            $table->foreign('order_id','order_id')
                ->references('id')->on('orders')
                ->onDelete('cascade')
                ->onUpdate('cascade');
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
        Schema::dropIfExists('recurrings');
    }
};
