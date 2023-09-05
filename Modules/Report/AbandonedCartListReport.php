<?php

namespace Modules\Report;
use Modules\Product\Entities\Product;
use Illuminate\Database\Eloquent\Builder;
use Modules\Cart\Entities\AbandonedListModel;
class AbandonedCartListReport extends Report
{
    protected $date = 'orders.created_at';

    protected function view()
    {

        
        return 'report::admin.reports.abandoned_cart_list_report.index';
    }

    public function query()
    {
        
        return Product::select('abandonedcartlistreport.id','abandonedcartlistreport.first_name','abandonedcartlistreport.last_name','abandonedcartlistreport.slug','abandonedcartlistreport.customer_id', 'abandonedcartlistreport.quantity','abandonedcartlistreport.rate', 'abandonedcartlistreport.product_id', 'abandonedcartlistreport.reason', 'abandonedcartlistreport.created_at')
        ->join('abandonedcartlistreport', 'products.id', '=', 'abandonedcartlistreport.product_id');
    }
}
