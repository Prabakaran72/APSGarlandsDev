<?php

namespace Modules\Report;

use Modules\Product\Entities\Product;
use Modules\Product\Entities\Brand;

class AbandonedWishlistReport extends Report
{
    protected function view()
    {
        return 'report::admin.reports.abandoned_wishlist.index';
    }

    protected function query()
    { 
        
        return Product::select('products.id','products.slug','products.price', 'wish_lists.reason','wish_lists.updated_at', 'users.first_name', 'users.last_name')
        ->join('wish_lists', 'products.id', '=', 'wish_lists.product_id')
        ->join('users', 'wish_lists.user_id', '=', 'users.id')
        ->where('is_deleted', 1);

        // return $this->belongsToMany(Product::class, 'wish_lists')->where('is_deleted', 0)->withTimestamps();                               
    }
}
