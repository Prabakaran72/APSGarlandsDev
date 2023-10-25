<?php

namespace Modules\Cart\Entities;

use Modules\Support\Eloquent\Model;
use Illuminate\Support\Facades\Cache;
use Modules\Product\Entities\Product;
use Modules\Support\Eloquent\Sluggable;
use Modules\Support\Eloquent\Translatable;

class AbandonedListModel extends Model
{
    //use HasFactory;
    Protected $table='abandonedcartlistreport';
    protected $fillable = ['slug', 'customer_id','quantity','rate','product_id','first_name','last_name'];
    protected $date = ['created_at','updated_at'];

}
