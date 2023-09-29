<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateBlogpostsMigrationTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('blogposts', function (Blueprint $table) {
            $table->increments('id');
            $table->string('post_title',50)->unique();
            $table->longText('post_body');
            $table->integer('category_id')->unsigned();
            $table->integer('tag_id')->unsigned();
            $table->integer('author_id')->unsigned();
            $table->enum('post_status',['pending', 'approved','rejected']) -> default('pending');
            $table->integer('approved_by')->unsigned()->nullable();
            $table->date('approved_date')->nullable()->nullable();
            $table->tinyInteger('is_active')->default(1)->nullable();
            $table->timestamps();
            $table->softDeletes();
            $table->foreign('category_id')->references('id')->on('blogcategorys')->onDelete('cascade');
            $table->foreign('tag_id')->references('id')->on('blogtags')->onDelete('cascade');
            $table->foreign('author_id')->references('id')->on('users')->onDelete('cascade');

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('blogposts');
    }
}
