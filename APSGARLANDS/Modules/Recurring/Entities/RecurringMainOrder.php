<?php

namespace Modules\Recurring\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class recurringMainOrder extends Model
{
    use HasFactory;

    protected $table = 'recurrings';
    protected $fillable = [];

    protected static function newFactory()
    {
        //return \Modules\Recurring\Database\factories\RecurringMainOrderFactory::new();
    }
}
