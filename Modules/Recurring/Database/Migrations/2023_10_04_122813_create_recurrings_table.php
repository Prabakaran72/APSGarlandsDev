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
            $table->unsignedInteger('created_user_id');
            $table->integer('max_preparing_days')->nullable();
            $table->time('delivery_time');
            $table->timestamp('created_at')->nullable();
            // Add foreign key constraint
            $table->foreign('created_user_id')
                ->references('id')->on('users')
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
        Schema::dropIfExists('recurrings');
    }
};
