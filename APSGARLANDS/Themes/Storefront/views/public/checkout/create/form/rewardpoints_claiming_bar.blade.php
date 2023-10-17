@php
echo setting('rewardpoints_enabled');
@endphp
@if (setting('rewardpoints_enabled') )
    <rewardpoints-claiming :customerrewardpoints ={{ json_encode($customerrewardpoints)}} inline-template>
        <div class="rewardpoint-bar-wrap" :class="{ show: show }" class="show">
            <div class="container d-flex justify-content-center">
                <div class="col-xl-10 col-lg-12">
                    <div class="row justify-content-center">
                        <div class="rewardpoint-bar">
                            <div class="rewardpoint-bar-text">
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
