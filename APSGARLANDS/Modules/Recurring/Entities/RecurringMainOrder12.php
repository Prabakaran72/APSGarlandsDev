<?php

namespace Modules\Recurring\Entities;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
//
use Modules\Support\Money;
use Modules\Cart\Facades\Cart;
use Modules\User\Entities\User;
use Modules\Order\Entities\Order;
use Illuminate\Support\Facades\DB;
use Modules\Recurring\Admin\RecurringTable;
use Modules\Product\Entities\Product;
use Modules\Category\Entities\Category;
use Modules\Support\Eloquent\Translatable;
use Illuminate\Database\Eloquent\SoftDeletes;
use Modules\Admin\Ui\AdminTable;
//


class recurring_main_order extends Model
{
    use HasFactory;

    protected $fillable = [];

    public function table()
    {
          //return new RecurringTable($this->newQuery()->withoutGlobalScope('active'));
        return new AdminTable($this->newQuery());
    }

    // protected static function newFactory()
    // {
    //     //return \Modules\Recurring\Database\factories\RecurringMainOrderFactory::new();
    // }
}
