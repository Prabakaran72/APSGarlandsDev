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
            $table->date('selected_date')->nullable();
            $table->enum('subscribe_status', ['0', '1'])->default('1');
            $table->string('order_status')->default(null)->nullable();
            // $table->unsignedInteger('updated_user_id')->nullable();
            $table->unsignedInteger('updated_user_id')->nullable()->default(NULL);

            // $table->timestamp('updated_at')->nullable();

            // Add foreign key constraints
            $table->foreign('recurring_id', 'recurring_id')
                ->references('id')->on('recurrings')
                ->onDelete('cascade')
                ->onUpdate('cascade');

            $table->foreign('updated_user_id', 'updated_user_id')
                ->references('id')->on('users')
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
        Schema::dropIfExists('recurring_sub_orders');
    }
};
