@if (setting('rewardpoints_enabled') && auth()->user())
    <div class="coupon-wrap" v-if='show'>
        <div class="form-group">
            <div class="form-input">
                <input type="number" v-model="reward.redeemedPoint"
                    placeholder="{{ trans('storefront::cart.enter_reward_point') }}" class="form-control"
                    >
            </div>

            <button type="button" class="btn btn-primary btn-apply-coupon" :class="{ 'btn-loading': redeemReward_btn }"
                @click.prevent="redeemRewardPoints">
                {{ trans('storefront::cart.redeem_reward') }}
            </button>
        </div>

        <span class="error-message" v-if="reward.error.status" v-text="reward.error.message">
        </span>
        <span v-if="settings.activeRewardPoints >= settings.use_points_per_order" class="reward-info">You have <span
                v-text="settings.activeRewardPoints"></span>
            reward points.Can Redeem upto <span v-text="settings.use_points_per_order"></span></span>
        <span v-if="settings.activeRewardPoints < settings.use_points_per_order" class="reward-info">You have <span
                v-text="settings.activeRewardPoints"></span>
            reward points.Can Redeem upto <span v-text="settings.activeRewardPoints"></span></span>
    </div>
@endif
