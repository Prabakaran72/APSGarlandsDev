<?php

namespace Modules\RewardpointsGift\Entities;

use Modules\User\Entities\User;
use Modules\Support\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
// use Modules\RewardpointsGift\Enums\RewardTypeEnum;
use Carbon\Carbon;
use Modules\RewardpointsGift\Admin\CustomerRewardPointsTable;
use Illuminate\Support\Facades\DB;
use Modules\Rewardpoints\Entities\Rewardpoints;

class CustomerRewardPoint extends Model
{
    use SoftDeletes;

    protected $fillable = ['id', 'customer_id', 'reward_type', 'reward_points_earned', 'claimed_reward_points', 'expiry_date'];

    protected $dates = ['deleted_at', 'created_at', 'updated_at'];

    /** 
     * Get the Log of Rewards Gained by  and Rewards Redeemed  by User
     *  @var array
     */
    public function getCustomerRewardsReedemLog()
    {
        return $result = 0;
    }

    /**  
     *  Get the Available of Reward points and equelent Amount per User
     *  @var array
     */
    public function getAvailableCustomerRewardsReedemption()
    {
        return $result = 0;
    }
    /**  
     *  Check if the user claimed 
     *  @var array
     */
    // public function is_customerGainedSignupReward(): bool
    // {
    //     return true;
    // }

    public function user()
    {
        return $this->belongsTo(User::class, 'customer_id');
    }

    public function rewardpoints()
    {
        return $this->belongsTo(Rewardpoints::class);
    }

    public function table()
    {
        $query = $this::with('user')
            ->select('customer_id')
            //     DB::raw('SUM(reward_points_earned) as reward_points_earned_total'),
            //     DB::raw('SUM(COALESCE(reward_points_claimed, 0)) as reward_points_earned_total'),
            //     DB::raw('SUM(CASE WHEN expiry_date < NOW() THEN reward_points_earned ELSE 0 END) as expired_earned_rewardpoints'),
            //     DB::raw('SUM(CASE WHEN expiry_date < NOW() AND created_at <= expiry_date THEN COALESCE(reward_points_claimed, 0) ELSE 0 END) as expired_claimed_rewardpoints'),
            //     DB::raw('SUM(CASE WHEN expiry_date >= NOW() THEN reward_points_earned ELSE 0 END) as in_live_earned_rewardpoints'),
            //     DB::raw('(SUM(reward_points_earned) - SUM(COALESCE(reward_points_claimed, 0)) - SUM(CASE WHEN expiry_date >= NOW() THEN reward_points_earned ELSE 0 END)) as expired_points')
            // )
            ->selectRaw('SUM(reward_points_earned) as reward_points_earned_total')
            // ->selectRaw('(total_earning - total_spent - total_expired_points) as in_live')
            ->selectRaw('SUM(reward_points_claimed) as  reward_points_claimed_total')
            ->selectRaw('SUM(CASE WHEN expiry_date IS NOT NULL AND expiry_date < NOW() THEN reward_points_earned ELSE 0 END) as expired_points')
            ->whereHas('user')
            ->groupBy('customer_id')
            ->newQuery();

        // $query1 = str_replace(array('?'), array('\'%s\''), $query->toSql());
        // $query1 = vsprintf($query1, $query->getBindings());
        // dd($query1);
        return new CustomerRewardPointsTable($query);
    }

    //getUserRewardpoints() - returns active rewardpoints for an auth user
    public function getUsersActiveRewardpoints()
    { 
        if(!empty(auth()->user()))
        {
            $result = DB::select('CALL GetCustomerEarnedTotal(?)',[auth()->user()->id]);
            return $result;
        }
        return false;
        
    }
    public function getRewardSetting()
    {
        return Rewardpoints::where('id', 1)->get();
    }

    public static function getUserRewardPoints()
    {
        //Get Rewardpoint Settings
        $modelInstance = new CustomerRewardPoint;
        $rewardSetting = $modelInstance->getRewardSetting();
        //get the active rewardpoints of a current user
        $activePoints = $modelInstance->getUsersActiveRewardpoints();
        // $result = DB::select('CALL YourStoredProcedureName(?, ?)', [$param1, $param2]);
        
        $customer_active_reward_points = $activePoints ? ($activePoints[0]->earned_total) : 0;
        
        $instance = [
            'activeRewardPoints' => $customer_active_reward_points > 0 ? $customer_active_reward_points : 0,
            "use_points_per_order" => $rewardSetting[0]['use_points_per_order'],
            "redeemedPoint" => $rewardSetting[0]['redeemedPoint'], //User's 'input
            "pointsEquolantCash" => $rewardSetting[0]['redemption_point_value'], //Ex 100 Points equal to 20MYR.SO 1pt  20/100 ie (.2)
            "min_order_cart_value_redemption" => $rewardSetting[0]['min_order_cart_value_redemption'],
            "currency_value" => $rewardSetting[0]['currency_value'], //if customer can earn rewardpoints, then currency 'rat'e
            "point_value" => $rewardSetting[0]['point_value'], //if customer can earn rewardpoints, then point values per order 'amoun't
            "redemption_point_value" => $rewardSetting[0]['redemption_point_value'],
            "redemption_currency_value" => $rewardSetting[0]['redemption_currency_value'],
        ];
        return $instance;
    }
   
}
