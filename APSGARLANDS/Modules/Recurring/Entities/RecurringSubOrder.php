<?php

namespace Modules\Recurring\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Modules\Admin\Ui\AdminTable;



class recurringSubOrder extends Model
{
    // use HasFactory;
    // protected $primaryKey = 'recurring_id';
    protected $table = 'recurring_sub_orders';
    protected $fillable = ['recurring_id', 'selected_date', 'subscribe_status','order_status','updated_user_id'];
    public $recurring_id = 0;

    public function table($id)
    {
        return new AdminTable($this->newQuery());
        // $recurring_main_order = recurringSubOrder::where('recurring_id',$recurring_id)->newQuery();

        // return new AdminTable($recurring_main_order);

    }

    // public function recurring()
    // {
    //     return $this->belongsTo(Recurring::class, 'recurring_id');
    // }
}
