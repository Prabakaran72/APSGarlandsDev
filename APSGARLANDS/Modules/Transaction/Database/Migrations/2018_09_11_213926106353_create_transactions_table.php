<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTransactionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('transactions', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('order_id')->unsigned()->unique();
            $table->string('transaction_id');
            $table->string('payment_method');
            $table->string('domain');
            $table->string('payment_Status');
            $table->decimal('amount', 10, 2); // Assuming 10 total digits with 2 decimal places
            $table->string('currency');
            $table->timestamp('paydate');
            $table->string('appcode');
            $table->string('error_code')->nullable();
            $table->string('error_desc')->nullable();
            $table->string('channel');
            $table->string('extra_p')->nullable();
            $table->softDeletes();
            $table->timestamps();

            $table->foreign('order_id')->references('id')->on('orders')->onDelete('cascade');
        });
    }
    
    /**zzz
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('transactions');
    }
}
