<?php

namespace Modules\Cart\Entities;

use Modules\Support\Eloquent\Model;
use Illuminate\Support\Facades\Cache;
use Modules\Product\Entities\Product;
use Modules\Support\Eloquent\Sluggable;
use Modules\Support\Eloquent\Translatable;
use Illuminate\Database\Eloquent\SoftDeletes;

class CartProduct extends Model
{
    //use HasFactory;
    use SoftDeletes;
    protected $fillable = ['cart_id', 'product_id', 'qty', 'option_id'];
    
    protected $dates = ['start_date', 'end_date', 'deleted_at'];
}
