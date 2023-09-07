<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class Createabandonedlisttable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('abandonedcartlistreport', function (Blueprint $table) {
            $table->increments('id');
            $table->string('slug')->unique();
            $table->string('customer_id');
            $table->float('quantity');
            $table->float('rate');
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
        Schema::dropIfExists('abandonedcartlistreport');
    }
}
