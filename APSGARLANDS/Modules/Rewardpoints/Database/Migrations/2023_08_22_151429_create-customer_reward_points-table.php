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
    // COMMENT = 'customer_reward_points is the table for capturing the reward points earned / processed by a customer';
    public function up()
    {
    // Schema::create('customer_reward_points_old', function (Blueprint $table) {
    //     $table->increments('id');
    //     $table->integer('user_id')->index();
    //     $table->integer('rewardpoints_id')->index();
    //     $table->integer('total_rewardpoints_allocated')->index();
    //     $table->integer('total_used_points')->index();
    //     $table->integer('total_unused_points')->index();
    //     $table->tinyInteger('is_active');
    //     $table->timestamp('deleted_at')->nullable();
    //     $table->timestamp('created_at')->nullable();
    //     $table->timestamp('updated_at')->nullable();
    
        // CREATE TABLE `apsbouquet`.`customer_reward_points` (
        //     `id` INT(11) NOT NULL AUTO_INCREMENT,
        //     `user_id` INT(11) NOT NULL,
        //     `rewardpoints_id` INT(11) NOT NULL,
        //     `total_rewardpoints_allocated` INT(11) NOT NULL,
        //     `total_used_points` INT(11) NULL,
        //     `total_unused_points` INT(11) NULL,
        //     `is_active` TINYINT(1) NOT NULL,
        //     `deleted_at` TIMESTAMP NULL DEFAULT NULL,
        //     `created_at` TIMESTAMP NULL DEFAULT NULL,
        //     `updated_at` TIMESTAMP NULL DEFAULT NULL,
        //     PRIMARY KEY (`id`))
        //   COMMENT = 'customer_reward_points is the table for capturing the reward points earned / processed by a customer';
    
    
    // });
}

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        // Schema::dropIfExists('customer_reward_points_old');
    }
};
