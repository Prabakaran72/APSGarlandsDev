<?php

namespace Modules\Blogtag\Entities;

use Modules\Support\Eloquent\TranslationModel;

class BlogtagTranslation extends TranslationModel
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['tag_name','tag_code','description'];
}
