<?php

namespace Modules\Cart\Entities;

use Modules\Support\Eloquent\Model;
use Illuminate\Support\Facades\Cache;
use Modules\Product\Entities\Product;
use Modules\Support\Eloquent\Sluggable;
use Modules\Support\Eloquent\Translatable;

class UserCart extends Model
{
    //use HasFactory;
    //use SoftDeletes;
    protected $table='carts';
    protected $fillable = ['customer_id'];
    
    protected $dates = ['start_date', 'end_date'];
}
