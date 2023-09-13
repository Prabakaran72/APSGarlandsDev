<?php

namespace Modules\RewardpointsGift\Entities;

use Modules\User\Entities\User;
use Modules\Support\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
// use Modules\RewardpointsGift\Enums\RewardTypeEnum;
use Carbon\Carbon;
use Modules\RewardpointsGift\Admin\CustomerRewardPointsTable;
use DB;

class CustomerRewardPoint extends Model
{
    use SoftDeletes;

    protected $fillable = ['id','customer_id','reward_type','earned_reward_points','claimed_reward_points'];
    
    protected $dates = ['expiry_date','deleted_at','created_at','updated_at'];
    
     /** 
        * Get the Log of Rewards Gained by  and Rewards Redeemed  by User
        *  @var array
    */
    public function getCustomerRewardsReedemLog(){
        return $result=0;
    }

    /**  
     *  Get the Available of Reward points and equelent Amount per User
    *  @var array
    */
    public function getAvailableCustomerRewardsReedemption(){
        return $result=0;
    }
    /**  
     *  Check if the user claimed 
    *  @var array
    */
    // public function is_customerGainedSignupReward(): bool
    // {
    //     return true;
    // }

    public function user(){
        return $this->belongsTo(User::class,'customer_id');
    }
    
    public function rewardpoints(){
        return $this->belongsTo(Rewardpoints::class);
    }

    public function table(){
        $query = $this::with('user')
        ->select('customer_id',
        DB::raw('SUM(reward_points_earned) as reward_points_earned_total'),
        DB::raw('SUM(COALESCE(reward_points_claimed, 0)) as reward_points_claimed_total'),
        DB::raw('SUM(CASE WHEN expiry_date < NOW() THEN reward_points_earned ELSE 0 END) as expired_earned_rewardpoints'),
        DB::raw('SUM(CASE WHEN expiry_date < NOW() AND created_at <= expiry_date THEN COALESCE(reward_points_claimed, 0) ELSE 0 END) as expired_claimed_rewardpoints'),
        DB::raw('SUM(CASE WHEN expiry_date >= NOW() THEN reward_points_earned ELSE 0 END) as in_live_earned_rewardpoints'),
        DB::raw('(SUM(reward_points_earned) - SUM(COALESCE(reward_points_claimed, 0)) - SUM(CASE WHEN expiry_date >= NOW() THEN reward_points_earned ELSE 0 END)) as expired_points')
    )
        ->whereHas('user')
        ->groupBy('customer_id')
        ->newQuery();
        return new CustomerRewardPointsTable($query);
    }
    }
