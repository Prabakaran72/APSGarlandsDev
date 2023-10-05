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
        Schema::create('fixedrates', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('pincode');
            $table->integer('flat_price');
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
        Schema::dropIfExists('fixedrates');
    }
};
