<?php

namespace Modules\Report;
use Modules\Product\Entities\Product;
use Illuminate\Database\Eloquent\Builder;
use Modules\Cart\Entities\AbandonedListModel;
use Modules\User\Entities\User;
class AbandonedCartListReport extends Report
{
    protected $date = 'orders.created_at';

    protected function view()
    {

        // $customer_name=User::get(auth()->user()->id);

        return 'report::admin.reports.abandoned_cart_list_report.index';
    }

    public function query()
    {
        
        return Product::select('abandonedcartlistreport.id','users.first_name','users.last_name','abandonedcartlistreport.slug','abandonedcartlistreport.customer_id', 'abandonedcartlistreport.quantity','abandonedcartlistreport.rate', 'abandonedcartlistreport.product_id', 'abandonedcartlistreport.reason', 'abandonedcartlistreport.created_at')
        ->join('abandonedcartlistreport', 'products.id', '=', 'abandonedcartlistreport.product_id')->join('users','users.id','=','abandonedcartlistreport.customer_id');
    }
}
