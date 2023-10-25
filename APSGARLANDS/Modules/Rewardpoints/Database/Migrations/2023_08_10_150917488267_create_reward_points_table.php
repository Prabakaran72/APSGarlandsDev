<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateRewardPointsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    // public function up() {
    //     Schema::create('reward_points_settings', function (Blueprint $table) {
    //         $table->increments('id');
    //         $table->integer('enable_bday_points')->index();
    //         $table->integer('enable_referral_points')->index();
    //         $table->integer('enable_show_customer_points')->index();
    //         $table->integer('enable_show_points_with_order')->index();
    //         $table->integer('enable_show_points_by_mail')->index();
    //         $table->integer('enable_give_old_order_points')->index();
    //         $table->integer('enable_remove_points_order_refund')->index();
    //         $table->integer('add_days_reward_points_expiry')->index();
    //         $table->integer('add_days_reward_points_assignment')->index();
    //         $table->integer('use_points_per_order')->index();
    //         $table->integer('min_order_cart_value_redemption')->index();
    //         $table->boolean('is_active');
    //         $table->date('start_date')->nullable();
    //         $table->date('end_date')->nullable();
    //         $table->softDeletes();
    //         $table->timestamps();
    //     });

    //     Schema::create('reward_points_values', function (Blueprint $table) {
    //         $table->increments('id');
    //         $table->integer('currency_value')->index();
    //         $table->integer('point_value')->index();
    //         $table->integer('redemption_point_value')->index();
    //         $table->integer('redemption_currency_value')->index();
    //         $table->integer('epoint_first_signup_value')->index();
    //         $table->integer('epoint_ref_point_value')->index();
    //         $table->integer('epoint_forder_point_value')->index();
    //         $table->integer('epoint_freview_point_value')->index();
    //         $table->integer('epoint_fpay_point_value')->index();
    //         $table->integer('epoint_bday_point_value')->index();
    //         $table->boolean('is_active');
    //         $table->date('start_date')->nullable();
    //         $table->date('end_date')->nullable();
    //         $table->softDeletes();
    //         $table->timestamps();
    //     });

    //     Schema::create('reward_customer_points', function (Blueprint $table) {
    //         $table->increments('id');
    //         $table->integer('user_id')->index();
    //         $table->integer('reward_point_value')->index();
    //         $table->string('reward_point_remarks')->index();
    //         $table->boolean('is_active');
    //         $table->date('start_date')->nullable();
    //         $table->date('end_date')->nullable();
    //         $table->softDeletes();
    //         $table->timestamps();
    //     });

    //     Schema::create('reward_notifications', function (Blueprint $table) {
    //         $table->increments('id');
    //         $table->integer('enable_apply_points_in_checkout_page')->index();
    //         $table->string('apply_notification_message')->index();
    //         $table->integer('enable_apply_points_rem_payment')->index();
    //         $table->string('apply_payment_noti_message')->index();
    //         $table->string('bday_noti_mail_message')->index();
    //         $table->integer('reward_point_value')->index();
    //         $table->string('reward_point_remarks')->index();
    //         $table->boolean('is_active');
    //         $table->date('start_date')->nullable();
    //         $table->date('end_date')->nullable();
    //         $table->softDeletes();
    //         $table->timestamps();
    //     });
    // }

    // /**
    //  * Reverse the migrations.
    //  *
    //  * @return void
    //  */
    // public function down() {
    //     Schema::dropIfExists('reward_points_settings');
    //     Schema::dropIfExists('reward_points_set_points_values');
    //     Schema::dropIfExists('reward_notifications');
    // }
}
