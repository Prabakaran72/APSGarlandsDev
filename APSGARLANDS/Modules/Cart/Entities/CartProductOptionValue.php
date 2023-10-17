<?php

namespace Modules\Cart\Entities;

use Modules\Support\Eloquent\Model;
use Illuminate\Support\Facades\Cache;
use Modules\Product\Entities\Product;
use Modules\Support\Eloquent\Sluggable;
use Modules\Support\Eloquent\Translatable;
//use Illuminate\Database\Eloquent\SoftDeletes;

class CartProductOptionValue extends Model
{
    //use HasFactory;
    //use SoftDeletes;
    protected $fillable = [];
    
    //protected $dates = ['start_date', 'end_date', 'deleted_at'];
}
