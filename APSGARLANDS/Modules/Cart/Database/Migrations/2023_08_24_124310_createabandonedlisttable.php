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
        Schema::create('abandonedcartlistreport', function (Blueprint $table) {
            $table->increments('id');
            $table->string('slug');
            $table->string('customer_id');
            $table->float('quantity');
            $table->float('rate');
            $table->string('product_id');
            $table->string('first_name');
            $table->string('last_name');
            $table->longText('reason');
            $table->timestamp('created_at')->useCurrent();
            $table->timestamp('updated_at')->useCurrentOnUpdate()->nullable();
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
};
