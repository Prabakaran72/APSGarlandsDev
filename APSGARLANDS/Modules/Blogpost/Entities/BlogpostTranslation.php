<?php

namespace Modules\Blogpost\Entities;

use Modules\Support\Eloquent\TranslationModel;

class BlogpostTranslation extends TranslationModel
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['post_name','post_code','description'];
}
