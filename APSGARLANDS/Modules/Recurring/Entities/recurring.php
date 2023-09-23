<?php

namespace Modules\Recurring\Entities;
use Illuminate\Support\Facades\DB;
use Modules\Support\Eloquent\Model;
use Modules\Recurring\Admin\RecurringTable;
use Illuminate\Database\Eloquent\SoftDeletes;
use Modules\Admin\Ui\AdminTable;
use Modules\Recurring\Entities\recurring_sub_order;


class Recurring extends Model
{

    //protected $table = 'recurring_main_orders';

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
