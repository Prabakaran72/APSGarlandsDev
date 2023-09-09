<?php

namespace Modules\RewardpointsGift\Entities;

use Modules\User\Entities\User;
use Modules\Support\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
// use Modules\RewardpointsGift\Enums\RewardTypeEnum;

class CustomerRewardPoint extends Model
{
    use SoftDeletes;

    protected $fillable = ['id','customer_id','reward_type','earned_reward_points','claimed_reward_points'];
    
    protected $dates = ['expairy_date','deleted_at','created_at','updated_at'];
    
    // protected $casts =[
    //     'reward_type' => 'enum:birthday, firstsignup, firstorder, firstpayment, firstreview, manualoffer',
    // ];

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



    }