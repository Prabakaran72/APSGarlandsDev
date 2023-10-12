

@if (setting('rewardpoints_enabled') )
@php 
$activeRewardPoints = 100;
$use_points_per_order = 50;
$redeemedPoint= null;
$pointsEquolantCase = 0.5; //Ex 100 Points equal to 20MYR.SO 1pt = 20/100 ie (.5)

$min_order_cart_value_redemption =150;
$currency_value=10; //if customer can earn rewardpoints, then currency rate
$point_value=1; //if customer can earn rewardpoints, then point values per order amount
$redemption_point_value=10;
$redemption_currency_value=1;
@endphp
    <rewardpoints-claiming inline-template>
        <div class="rewardpoint-bar-wrap" :class="{ show: show }">
            <div class="container d-flex justify-content-center">
                <div class="col-xl-10 col-lg-12">
                    <div class="row justify-content-center">
                        <div class="rewardpoint-bar">
                            <div class="rewardpoint-bar-text">
                                {{-- {{ trans('storefront::layout.customer_have_rewardpoints_to_claim',['activeRewardPoints'=>$activeRewardPoints, 'maxLimitRewardpoints'=>$use_points_per_order])}} --}}
                                You have <span v-text="rewardPoints.activeRewardPoints"></span>
                                reward points to claim. You Can Redeem upto <span
                                    v-text="rewardPoints.use_points_per_order"></span>
                            </div>
                            <div class="rewardpoint-bar-text">
                               <input type="number" placeholder="No of points..." v-model="rewardPoints.redeemedPoint" step="1"/>
                               <label v-if="rewardPoints.error.status==true" v-text="rewardPoints.error.message" class="text-right"></label>
                            </div>

                            <div class="rewardpoint-bar-action">
                                <button class="btn btn-primary btn-accept" @click="redeemRewardPoints">
                                    {{ trans('storefront::layout.claim_reward_button') }}
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </rewardpoints-claiming>
@endif
