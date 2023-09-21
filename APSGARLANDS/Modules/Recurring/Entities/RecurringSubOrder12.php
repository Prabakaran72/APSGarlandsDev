<?php

namespace Modules\Recurring\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class recurring_sub_order extends Model
{
    // use HasFactory;

    protected $fillable = ['id', 'order_id', 'recurring_id', 'order_date','delivery_date','status','created_at','update_at'];

    protected static function newFactory()
    {
        //return \Modules\Recurring\Database\factories\RecurringSubOrderFactory::new();
    }

    // public function recurringMainOrder()
    // {
    //     return $this->belongsTo(Recurring::class);
    // }
}
