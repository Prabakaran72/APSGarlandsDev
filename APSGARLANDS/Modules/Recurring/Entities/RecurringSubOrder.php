<?php

namespace Modules\Recurring\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class recurringSubOrder extends Model
{
    use HasFactory;

    protected $table = 'recurring_sub_orders';
    protected $fillable = [];

    protected static function newFactory()
    {
        //return \Modules\Recurring\Database\factories\RecurringSubOrderFactory::new();
    }
}
