<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('pickupstores', function (Blueprint $table) {
            $table->increments('id');
            $table->string('name');
            $table->string('tagline')->nullable();
            $table->string('email');
            $table->string('phone');
            $table->string('address_1');
            $table->string('address_2');
            $table->string('city');
            $table->string('store_state');
            $table->string('store_country');
            $table->string('zip');
            $table->boolean('is_active');
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
        Schema::dropIfExists('pickupstores');
    }
};
