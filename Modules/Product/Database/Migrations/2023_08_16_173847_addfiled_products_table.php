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
        //
        Schema::table('products', function (Blueprint $table) {
           
            
            $table->integer('prepare_days')->unsigned()->after('new_to');
            $table->text('pre_short_description')->nullable();
            $table->boolean('is_preorder_status');
        });
    }
    

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
        Schema::table('products', function (Blueprint $table) {
           
            $table->dropColumn('prepare_days');
            $table->dropColumn('pre_short_description');
            $table->dropColumn('is_preorder_status');
        });
    }
};
