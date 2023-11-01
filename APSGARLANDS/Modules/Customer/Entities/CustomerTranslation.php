<?php

namespace Modules\Customer\Entities;

use Modules\Support\Eloquent\TranslationModel;

class CustomerTranslation extends TranslationModel
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['name', 'body'];
}
