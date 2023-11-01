<?php

namespace Modules\OrderSubscription\Entities;

use Modules\Support\Eloquent\TranslationModel;

class OrderSubscriptionTranslation extends TranslationModel
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['name'];
}
