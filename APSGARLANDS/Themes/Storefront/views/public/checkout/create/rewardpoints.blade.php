<div class="rewardpoints-wrap"> 
    
    <div class="form-group">
        <div class="form-input">
            <input
                type="text"
                v-model="rewardPoints"
                placeholder="{{ trans('storefront::cart.enter_reward_points') }}"
                class="form-control"
                @input="rewardPointsError = null"
            >
            <span
                class="error-message"
                v-if="rewardPointsError"
                v-text="rewardPointsError"
            >
            </span>
        </div>

        <button
            type="button"
            class="btn btn-primary btn-apply-rewardpoints"
            :class="{ 'btn-loading': applyingCoupon }"
            @click.prevent="applyRewardPoints"
        >
            {{ trans('storefront::cart.apply_Reward') }}
        </button>
    </div>
    <span
        class="error-message"
        v-if="rewardPointsError"
        v-text="rewardPointsError"
    >
    </span>
</div>
