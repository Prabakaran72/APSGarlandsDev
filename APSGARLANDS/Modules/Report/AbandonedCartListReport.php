<?php
namespace Modules\Report;
use Modules\Product\Entities\Product;
use Illuminate\Database\Eloquent\Builder;
use Modules\Cart\Entities\CartProduct;
use Modules\User\Entities\User;
class AbandonedCartListReport extends Report
{
   protected $date='cart_products.deleted_at';

    protected function view()
    {
        return 'report::admin.reports.abandoned_cart_list_report.index';
    }

    public function query()
    {

        return Product::select('users.first_name','users.last_name','cart_products.id','products.slug','cart_products.customer_id', 'cart_products.qty','products.price', 'cart_products.product_id', 'cart_products.reason', 'cart_products.deleted_at')
        ->join('cart_products', 'products.id', '=', 'cart_products.product_id')
        ->join('users', 'users.id', '=', 'cart_products.customer_id')
        ->whereNotNull('cart_products.deleted_at')
        ->when(request()->has('product'), function ($query) {
            $query->whereTranslationLike('name', request('product') . '%');
        })->when(request()->has('from'), function ($query) {
            if(request('to')==''){
                $from = request('from');
                $to = now()->format('Y-m-d');
            }else{
                $from = request('from');
                $to = request('to');
            }
            $query->whereRaw("DATE_FORMAT(cart_products.deleted_at, '%Y-%m-%d') >= ?", [$from])
            ->whereRaw("DATE_FORMAT(cart_products.deleted_at, '%Y-%m-%d') <= ?", [$to]);
        });
    }
}
