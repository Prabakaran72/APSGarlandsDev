<?php

namespace Modules\Report;
use Illuminate\Support\Facades\DB;
use Modules\Product\Entities\Product;
use Modules\User\Entities\User;
use Modules\Product\Entities\Brand;
use Modules\Support\Eloquent\Model;
use Modules\Support\Search\Searchable;
use Illuminate\Database\Eloquent\Builder;


class AbandonedWishlistReport extends Report
{
    protected $date='wish_lists.updated_at';

    protected function view()
    {
        return 'report::admin.reports.abandoned_wishlist.index';
    }

    protected function query()
    { 
        
        // return Product::select('products.id','products.slug','products.price', 'wish_lists.reason','wish_lists.updated_at', 'users.first_name', 'users.last_name')
        // ->join('wish_lists', 'products.id', '=', 'wish_lists.product_id')
        // ->join('users', 'wish_lists.user_id', '=', 'users.id')       
        // ->where('is_deleted', 1);                       
        

        return  Product::select('products.id','products.slug','products.price', 'wish_lists.reason','wish_lists.updated_at', 'users.first_name', 'users.last_name')
                ->when(request()->has('products'), function (Builder $query) {
                    $query->whereTranslationLike('name', '%' . request('products') . '%');
                })
                ->join('wish_lists', 'products.id', '=', 'wish_lists.product_id')
                ->join('users', 'wish_lists.user_id', '=', 'users.id')
                // ->selectRaw('MIN(wish_lists.updated_at) as start_date')
                // ->selectRaw('MAX(wish_lists.updated_at) as end_date')
                ->where('wish_lists.is_deleted', 1);                       
    }
    
    

}
