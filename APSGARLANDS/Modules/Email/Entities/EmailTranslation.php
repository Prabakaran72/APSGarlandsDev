<?php

namespace Modules\Email\Entities;

use Modules\Support\Eloquent\TranslationModel;

class EmailTranslation extends TranslationModel
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['name', 'body'];
}
