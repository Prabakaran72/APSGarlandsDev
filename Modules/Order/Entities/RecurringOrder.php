<?php

namespace Modules\Order\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class recurring_order extends Model
{
    use HasFactory;

    protected $fillable = ['recurring_frequency','recurring_start_date','recurring_end_date','recurring_time'];

    // protected static function newFactory()
    // {
    //     return \Modules\Order\Database\factories\RecurringOrderFactory::new();
    // }
}
