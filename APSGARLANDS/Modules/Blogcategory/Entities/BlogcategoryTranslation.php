<?php

namespace Modules\Blogcategory\Entities;

use Modules\Support\Eloquent\TranslationModel;

class BlogcategoryTranslation extends TranslationModel
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['category_name','category_code','description'];
}
