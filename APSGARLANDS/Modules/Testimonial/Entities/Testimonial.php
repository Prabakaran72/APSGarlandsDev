<?php

namespace Modules\Testimonial\Entities;

use Modules\Support\Money;
use Modules\Cart\Facades\Cart;
use Modules\User\Entities\User;
use Modules\Order\Entities\Order;
use Illuminate\Support\Facades\DB;
use Modules\Support\Eloquent\Model;
use Modules\Testimonial\Admin\TestimonialTable;
use Modules\Product\Entities\Product;
use Modules\Category\Entities\Category;
use Modules\Support\Eloquent\Translatable;
use Illuminate\Database\Eloquent\SoftDeletes;
use Modules\Admin\Ui\AdminTable;

class Testimonial extends Model
{

    protected $fillable = [
        'user_id',
        'user_name',
        'comment',
        'is_active',
    ];

    public function table()
    {
          //return new TestimonialTable($this->newQuery()->withoutGlobalScope('active'));
        return new AdminTable($this->newQuery());
    }


}
