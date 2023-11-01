<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCategoryTranslationsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('ordersubscription_translations', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('ordersubscription_id')->unsigned();
            $table->string('locale');
            $table->string('name');

            $table->unique(['category_id', 'locale']);
            $table->foreign('category_id')->references('id')->on('ordersubscriptions')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('ordersubscription_translations');
    }
}
