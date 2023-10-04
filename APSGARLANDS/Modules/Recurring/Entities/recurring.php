<?php

namespace Modules\Recurring\Entities;

use Illuminate\Support\Facades\DB;
use Modules\Support\Eloquent\Model;
use Modules\Recurring\Admin\RecurringTable;
use Illuminate\Database\Eloquent\SoftDeletes;
use Modules\Admin\Ui\AdminTable;
use Modules\Recurring\Entities\recurring_sub_order;
use Modules\User\Entities\User;


class Recurring extends Model
{

    //protected $table = 'recurring_main_orders';

    protected $fillable = ['id', 'order_id', 'created_user_id', 'delivery_time'];

    public function table()
    {
        //return new RecurringTable($this->newQuery()->withoutGlobalScope('active'));
        $query = $this::with('user')->newQuery();
        return new RecurringTable($query);
    }


    public function user()
    {
        return $this->belongsTo(User::class, 'created_user_id');
    }

    // public function getCustomerNameAttribute()
    // {
    //     return ucfirst($this->first_name) . " " . ucfirst($this->last_name);
    // }

    public function recurringSubOrders()
    {
        return $this->hasMany(RecurringSubOrder::class, 'recurring_id');
    }
}
