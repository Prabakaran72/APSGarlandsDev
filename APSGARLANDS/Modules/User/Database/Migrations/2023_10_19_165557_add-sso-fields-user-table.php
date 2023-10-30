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
        Schema::table('users', function (Blueprint $table) {
            $table->text('image_url')->after('last_login')->nullable(); 
            $table->smallInteger('is_sso_google',1)->after('image_url')->nullable()->default(0); 
            $table->string('sso_id',45)->after('is_sso_google')->nullable()->default(null); 
            $table->string('sso_username',50)->after('sso_id')->nullable()->default(null); 
            $table->string('sso_locale',25)->after('sso_username')->nullable()->default(null); 
            $table->text('sso_avatar')->after('sso_locale')->nullable()->default(Null); 
            $table->smallInteger('is_sso_fb',1)->after('sso_avatar')->nullable()->default(0); 
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn('image_url');
            $table->dropColumn('is_sso_google');
            $table->dropColumn('sso_id');
            $table->dropColumn('sso_username');
            $table->dropColumn('sso_locale');
            $table->dropColumn('sso_avatar');
            $table->dropColumn('is_sso_fb');
        });
    }
};
