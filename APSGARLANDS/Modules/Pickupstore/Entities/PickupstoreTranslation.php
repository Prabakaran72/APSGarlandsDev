<?php

namespace Modules\Pickupstore\Entities;

use Modules\Support\Eloquent\TranslationModel;

class PickupstoreTranslation extends TranslationModel
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['name', 'body'];
}
