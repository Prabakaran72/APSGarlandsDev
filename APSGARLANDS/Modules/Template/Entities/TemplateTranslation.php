<?php

namespace Modules\Template\Entities;

use Modules\Support\Eloquent\TranslationModel;

class TemplateTranslation extends TranslationModel
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['name', 'body'];
}
