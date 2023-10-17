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
        Schema::create('cart_products', function (Blueprint $table) {
        $table->increments('id');    
        $table->integer('cart_id');
		$table->integer('product_id');
		$table->integer('qty');
		$table->integer('option_id');
		$table->timestamp('created_at')->useCurrent();
        $table->timestamp('updated_at')->useCurrentOnUpdate()->nullable();
		$table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('cart_products', function (Blueprint $table) {
            //
        });
    }
};
