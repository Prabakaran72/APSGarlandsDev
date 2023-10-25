<?php

namespace Modules\Rewardpoints\Entities;

use Modules\Support\Money;
use Modules\Cart\Facades\Cart;
use Modules\User\Entities\User;
use Modules\Order\Entities\Order;
use Illuminate\Support\Facades\DB;
use Modules\Support\Eloquent\Model;
use Modules\Rewardpoints\Admin\RewardpointsTable;
use Modules\Product\Entities\Product;
use Modules\Category\Entities\Category;
use Modules\Support\Eloquent\Translatable;
use Illuminate\Database\Eloquent\SoftDeletes;
use Modules\User\Entities\Role;
use Carbon\Carbon;

class Rewardpoints extends Model
{
    // use Translatable,
    use SoftDeletes;
        // Concerns\SyncRelations,
        // Concerns\RelationList;

    /**
     * The relations to eager load on every query.
     *
     * @var array
     */
    // protected $with = ['translations'];
    // protected $with = ['translations'];
    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'add_days_reward_points_expiry',
        'add_days_reward_points_assignment',
        'use_points_per_order',
        'min_order_cart_value_redemption',
        'currency_value',
        'point_value',
        'redemption_point_value',
        'redemption_currency_value',
        'epoint_first_signup_value',
        // 'epoint_ref_point_value',
        'epoint_forder_point_value',
        'epoint_freview_point_value',
        'epoint_fpay_point_value',
        'epoint_bday_point_value',
        'apply_notification_message',
        'enable_apply_points_rem_payment',
        'apply_payment_noti_message',
        'bday_noti_mail_message',
        // 'reward_point_value',
        // 'reward_point_remarks',
        // 'user_id'
    ];

        protected $guarded = [];
    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'enable_bday_points'  =>   'boolean',
        // 'enable_referral_points'    =>  'boolean',
        'enable_show_customer_points'    =>  'boolean',
        'enable_show_points_with_order'    =>  'boolean',
        'enable_show_points_by_mail'    =>  'boolean',
        'enable_give_old_order_points'    =>  'boolean',
        'enable_apply_points_in_checkout_page'    =>  'boolean',
        'enable_remove_points_order_refund'    =>  'boolean',
        // 'is_active' => 'boolean',
        ];

    /**
     * The attributes that should be mutated to dates.
     *
     * @var array
     */
    protected $dates = ['start_date', 'end_date', 'deleted_at'];

    /**
     * The attributes that are translatable.
     *
     * @var array
     */
    // protected $translatedAttributes = ['name'];

    protected $customer_list =[];
    /**
     * Perform any actions required after the model boots.
     *
     * @return void
     */
    // protected static function booted()
    // {
    //     static::saved(function ($rewardpoints) {
    //         $rewardpoints->saveRelations(request()->all());
    //     });

    //     static::addActiveGlobalScope();
    // }

    public static function findByCode($code)
    {
        return self::where(DB::raw('BINARY `code`'), $code)->first();
    }

    public function enable_bday_points()
    {
        return $this->enable_bday_points ? $this : (object) ['enable_bday_points' => 0];
    }

    public function enable_show_customer_points()
    {
        return $this->enable_show_customer_points ? $this : (object) ['enable_show_customer_points' => 0];
    }

    public function enable_show_points_with_order() {
        return $this->enable_show_points_with_order ? $this : (object) ['enable_show_points_with_order' => 0];
    }

    public function enable_show_points_by_mail() {
        return $this->enable_show_points_by_mail ? $this : (object) ['enable_show_points_by_mail' => 0];
    }

    public function enable_give_old_order_points() {
        return $this->enable_give_old_order_points ? $this : (object) ['enable_give_old_order_points' => 0];
    }

    public function enable_remove_points_order_refund() {
        return $this->enable_remove_points_order_refund ? $this : (object) ['enable_remove_points_order_refund' => 0];
    }

    public function valid()
    {
        if ($this->hasStartDate() && $this->hasEndDate()) {
            return $this->startDateIsValid() && $this->endDateIsValid();
        }

        if ($this->hasStartDate()) {
            return $this->startDateIsValid();
        }

        if ($this->hasEndDate()) {
            return $this->endDateIsValid();
        }

        return true;
    }

    public function invalid()
    {
        return ! $this->valid();
    }

    private function hasStartDate()
    {
        return ! is_null($this->start_date);
    }

    private function hasEndDate()
    {
        return ! is_null($this->end_date);
    }

    private function startDateIsValid()
    {
        return today() >= $this->start_date;
    }

    private function endDateIsValid()
    {
        return today() <= $this->end_date;
    }

    public function usageLimitReached($customerEmail = null)
    {
        return $this->perRewardpointsUsageLimitReached() || $this->perCustomerUsageLimitReached($customerEmail);
    }

    public function perRewardpointsUsageLimitReached()
    {
        if (is_null($this->usage_limit_per_rewardpoints)) {
            return false;
        }

        return $this->used >= $this->usage_limit_per_rewardpoints;
    }

    public function perCustomerUsageLimitReached($customerEmail = null)
    {
        if ($this->rewardpointsHasNoUsageLimitForCustomers() ||
            $this->userIsNotLoggedInWhenAddingRewardpointsToCart($customerEmail)
        ) {
            return false;
        }

        $customerEmail = $customerEmail ?: auth()->user()->email;

        $used = $this->orders()
            ->where('customer_email', $customerEmail)
            ->count();

        return $used >= $this->usage_limit_per_customer;
    }

    private function rewardpointsHasNoUsageLimitForCustomers()
    {
        return is_null($this->usage_limit_per_customer);
    }

    private function userIsNotLoggedInWhenAddingRewardpointsToCart($customerEmail = null)
    {
        return is_null($customerEmail) && auth()->guest();
    }

    public function didNotSpendTheRequiredAmount()
    {
        if (is_null($this->minimum_spend)) {
            return false;
        }

        return Cart::subTotal()->lessThan($this->minimum_spend);
    }

    public function spentMoreThanMaximumAmount()
    {
        if (is_null($this->maximum_spend)) {
            return false;
        }

        return Cart::subTotal()->greaterThan($this->maximum_spend);
    }

    public function products()
    {
        return $this->belongsToMany(Product::class, 'rewardpoints_products')
            ->withPivot('exclude')
            ->wherePivot('exclude', false);
    }

    public function excludeProducts()
    {
        return $this->belongsToMany(Product::class, 'rewardpoints_products')
            ->withPivot('exclude')
            ->wherePivot('exclude', true);
    }

    public function categories()
    {
        return $this->belongsToMany(Category::class, 'rewardpoints_categories')
            ->withPivot('exclude')
            ->wherePivot('exclude', false);
    }

    public function excludeCategories()
    {
        return $this->belongsToMany(Category::class, 'rewardpoints_categories')
            ->withPivot('exclude')
            ->wherePivot('exclude', true);
    }

    public function orders()
    {
        return $this->user->hasMany(Order::class, 'customer_id', 'user_id');
    }
    // public function customers_orders()
    // {
    //     dd($this->customer_list['id']);
    //     return Order::whereIn('customer_id', $this->customer_list);
    // }

    // public function customers()
    // {
    //     $data = $this->customer_list = User::whereHas('roles', function ($query) {
    //         $query->where('role_id','!=',1);
    //         })->get();
        
    //     $userArr=[];
    //         foreach($data as $coll) 
    //         {
    //             $user= User::find($coll->id);
    //             $orderConut = $user->orders()->count();
    //             $orderSum = number_format($user->orders()->sum('total'), 2);
    //             $totRewardPts = $user->rewardpoints()->reward_point_value ?? 0;
    //             /* 
    //             * Total Reward Amount is calculated based on   pointvalue(100)/Currency_value(10) ie., 100 point is worth of 10 currency. so for a point to currency ratio is 100/10 = 10. 
    //             * Total amount is calculated by currency equalent pointvalue * offered points ie., if vendor offeres 50 reward points to a customer so the customer can avail the amount of 50 * (10/100) = 5
    //             */

    //             $result = $user->rewardpoints;
    //             if ($result) {
    //                 $redemptionCurrencyValue = $result->redemption_currency_value;
    //                 $redemptionPointValue = $result->redemption_point_value;
    //                 $rewardPointValue = $result->reward_point_value;
                
    //                 // Perform the calculation
    //                 $totRewardAmt = $redemptionPointValue != 0 ? (($redemptionCurrencyValue / $redemptionPointValue) * $rewardPointValue) : 0;
    //             } else {
    //                 $totRewardAmt = 0;
    //             }

    //             // $totRewardAmt = $user->rewardpoints()->reward_point_value ? (($user->rewardpoints()->redemption_currency_value /$user->rewardpoints()->redemption_point_value)*$user->rewardpoints()->reward_point_value): 0 ;
                
    //             array_push($userArr, ['id'=>$coll->id, "email"=>$coll->email,"order_count"=>$orderConut,"order_total"=>$orderSum,"total_rewardpoints"=>$totRewardPts,"total_amount"=>$totRewardAmt]);   
    //         }
    //         return $userArr;
    
    // }
    public function getUserOrderCount($args){
        
    }   
  

    public function getValueAttribute($value)
    {
        if ($this->is_percent) {
            return $value;
        }

        return Money::inDefaultCurrency($value);
    }

    public function getMinimumSpendAttribute($minimumSpend)
    {
        if (! is_null($minimumSpend)) {
            return Money::inDefaultCurrency($minimumSpend);
        }
    }

    public function getMaximumSpendAttribute($maximumSpend)
    {
        if (! is_null($maximumSpend)) {
            return Money::inDefaultCurrency($maximumSpend);
        }
    }

    public function getTotalAttribute($total)
    {
        return Money::inDefaultCurrency($total);
    }

    /**
     * Get table data for the resource
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function table()
    {
        // return new RewardpointsTable($this->newQuery()->withoutGlobalScope('active'));
        return new RewardpointsTable($this->newQuery());
    }

    /**
     * Save associated relations for the rewardpoints.
     *
     * @param array $attributes
     * @return void
     */
    public function saveRelations(array $attributes)
    {
        $this->syncProducts(array_get($attributes, 'products', []));
        $this->syncExcludeProducts(array_get($attributes, 'exclude_products', []));

        $this->syncCategories(array_get($attributes, 'categories', []));
        $this->syncExcludeCategories(array_get($attributes, 'exclude_categories', []));
    }

    public function listcustomers()
    {
        // return $this->hasManyThrough(
        //     User::class,
        //     Order::class,
        //     'rewardpoints_id',
        //     'customer_id',
        //     'id',
        //     'id'
        // );
    }
    public function user()
    {
        // return $this->hasMany(User::class,'user_id','id');
        return $this->belongsTo(User::class, 'user_id');
    }

    
    public function getTotalNoOfOrdersAttribute()
    {
        return $this->user->orders->count();
    }

    public function getTotalOrderAmountAttribute()
    {
        return $this->user->orders->sum('total');
    }

    public function getTotalRewardPointsEarnedAttribute()
    {
        $total_points_earned = $this->enable_bday_points + $this->enable_referral_points+ $this->enable_show_customer_points+ $this->reward_point_value;
        return $total_points_earned;
    }

    public function getTotalRewardAmountAttribute()
    {
        $total_reward_amount =  abs($this->getTotalRewardPointsEarnedAttribute()/$this->getRedemptionCurrencyValueAttribute());

        return $total_reward_amount;
    }

    public function getUsersWithOrdersAndRewards()
    {
        
       $users= new User();
        $customer = Rewardpoints::whereHas('user.role', function ($query) {
            $query->where('role_id', '!=', 1);
        })->get();
        
        // $users = User::whereHas('roles', function ($query) {
        //     $query->where('name', 'admin');
        // })->get();
        // dd($users);


    //    $result = static::with('user')
    //         ->whereHas('user.roles', function ($query) {
    //             $query->where('role_id', '!=', 1);
    //         })
    //         ->get();
        // dd($result);
    }

    // public function getRedemptionPointValueAttribute(){
    //     return $this->redemption_point_value;        
    // }
    // public function getRedemptionCurrencyValueAttribute(){
    //     return $this->redemption_currency_value;
    // }

    public function getRewardPointsSettings(){
        return $this->where('id', 1)->first();
    }
    
    public function getRewardPointsExpirationDays()
    {
        return $this->select('add_days_reward_points_expiry')->where('id', 1)->first();
    }
   
    public function getRewardPointsExpiryDate()
    {
        $expiration_days = $this->select('add_days_reward_points_expiry')->where('id', 1)->first();
        return Carbon::now()->addDays($expiration_days->add_days_reward_points_expiry);
    }

}
