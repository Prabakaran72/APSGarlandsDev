<?php
namespace Modules\Report;
use Modules\Product\Entities\Product;
use Illuminate\Database\Eloquent\Builder;
use Modules\Cart\Entities\AbandonedListModel;
use Modules\User\Entities\User;
class AbandonedCartListReport extends Report
{
   protected $date='abandonedcartlistreport.created_at';
    
    protected function view()
    {
        return 'report::admin.reports.abandoned_cart_list_report.index';
    }

    public function query()
    {
        
        return Product::select('abandonedcartlistreport.id','abandonedcartlistreport.first_name','abandonedcartlistreport.last_name','abandonedcartlistreport.slug','abandonedcartlistreport.customer_id', 'abandonedcartlistreport.quantity','abandonedcartlistreport.rate', 'abandonedcartlistreport.product_id', 'abandonedcartlistreport.reason', 'abandonedcartlistreport.created_at')
        ->join('abandonedcartlistreport', 'products.id', '=', 'abandonedcartlistreport.product_id')
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
            $query->whereRaw("DATE_FORMAT(abandonedcartlistreport.created_at, '%Y-%m-%d') >= ?", [$from])
            ->whereRaw("DATE_FORMAT(abandonedcartlistreport.created_at, '%Y-%m-%d') <= ?", [$to]);
        });
    }
}
