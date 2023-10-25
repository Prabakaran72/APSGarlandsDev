<?php

namespace Modules\Rewardpoints\Entities;

use Modules\Support\Eloquent\TranslationModel;

class RewardpointsTranslation extends TranslationModel
{
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = ['name'];
}
