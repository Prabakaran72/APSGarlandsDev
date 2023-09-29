<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateBlogtagsMigrateTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('blogtags', function (Blueprint $table) {
            $table->increments('id');
            $table->string('tag_name',50)->unique();
            $table->string('tag_code',5);
            $table->tinyInteger('is_active')->default(1)->nullable();
            $table->string('description',50)->nullable();
            $table->timestamps();
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
        Schema::dropIfExists('blogtags');
    }
}
?>
