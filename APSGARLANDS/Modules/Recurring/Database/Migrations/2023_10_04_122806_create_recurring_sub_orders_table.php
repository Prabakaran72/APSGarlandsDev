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
            $table->increments('id');
            $table->unsignedInteger('recurring_id');
            $table->unsignedInteger('order_id');
            $table->date('selected_date')->nullable();
            $table->date('delivery_date')->nullable();
            $table->enum('is_active', ['0', '1'])->default('1');
            $table->unsignedInteger('updated_user_id')->nullable();
            // $table->timestamps();
            $table->timestamp('updated_at')->nullable();

            // Add foreign key constraints
            $table->foreign('recurring_id')
                ->references('id')->on('recurrings')
                ->onDelete('cascade')
                ->onUpdate('cascade');

            $table->foreign('order_id')
                ->references('id')->on('orders')
                ->onDelete('cascade')
                ->onUpdate('cascade');
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
