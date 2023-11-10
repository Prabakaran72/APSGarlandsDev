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
        Schema::table('orders', function (Blueprint $table) {
            $table->bigInteger('rewardpoints_id')->nullable()->unsigned()->after('discount');
            $table->foreign('rewardpoints_id')
                ->references('id')
                ->on('customer_reward_points') // Name of the referenced table
                ->onUpdate('cascade') // Cascade update if the referenced ID is updated
                ->onDelete('cascade'); // Set the foreign key column to NULL if the referenced ID is deleted
            $table->decimal('redemption_amount', 10, 2);
            $table->string('shipping_last_name')->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('orders', function (Blueprint $table) {
            $table->integer('rewardpoints_id');
            $table->dropForeign(['rewardpoints_id']);
            $table->decimal('redemption_amount', 10, 2);
        });
    }
};
