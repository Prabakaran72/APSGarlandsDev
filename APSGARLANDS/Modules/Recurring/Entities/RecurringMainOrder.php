<?php

namespace Modules\Recurring\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Modules\Admin\Ui\AdminTable;


class recurringMainOrder extends Model
{
    use HasFactory;

    protected $table = 'recurring_main_orders';

    protected $fillable = ['id', 'order_id', 'customer_id', 'delivery_time'];

    public function table()
    {
          //return new RecurringTable($this->newQuery()->withoutGlobalScope('active'));
        return new AdminTable($this->newQuery());
    }

    public function recurring_sub_datas(){
        return $this->hasMany(recurringSubOrder::class);
    }

    public function users(){
        return $this->belongsTo(User::class,'created_id');
    }

}
