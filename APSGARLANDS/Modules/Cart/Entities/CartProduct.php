<?php

namespace Modules\Cart\Entities;

use Modules\Support\Eloquent\Model;
use Illuminate\Support\Facades\Cache;
use Modules\Product\Entities\Product;
use Modules\Support\Eloquent\Sluggable;
use Modules\Support\Eloquent\Translatable;
use Illuminate\Database\Eloquent\SoftDeletes;
use Modules\Cart\Entities\UserCart;
class CartProduct extends Model
{
    //use HasFactory;
    use SoftDeletes;
    protected $fillable = ['cart_id', 'product_id', 'qty', 'option_id'];
    
    protected $dates = ['start_date', 'end_date', 'deleted_at'];

    public function product()
{
    return $this->belongsTo(Product::class, 'product_id');
}
public function usercart()
{
    return $this->belongsTo(UserCart::class, 'cart_id');
}
}
