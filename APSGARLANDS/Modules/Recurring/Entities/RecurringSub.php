<?php

namespace Modules\Recurring\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class recurringSub extends Model
{
    use HasFactory;

    protected $fillable = [];

    protected static function newFactory()
    {
       // return \Modules\Recurring\Database\factories\RecurringSubFactory::new();
    }
}
