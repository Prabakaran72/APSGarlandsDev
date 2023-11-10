<?php

namespace Modules\Checkout\Listeners;

use Modules\Checkout\Events\OrderPlaced;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Modules\Rewardpoints\Entities\Rewardpoints;
use Modules\RewardpointsGift\Entities\CustomerRewardPoint;
use Modules\Setting\Entities\Setting;
use Illuminate\Support\Facades\Log;
use Modules\User\Emails\RewardPointsEarnedMail;
use Illuminate\Support\Facades\Mail;
use Modules\User\Entities\User;

class EarnFirstOrderReward
{
    /**
     * Create the event listener.
     *
     * @return void
     */
    protected $custRewPts;
    protected $rewardSettings;
    protected $settings;
    public function __construct(Rewardpoints $rewardSettings, CustomerRewardPoint $custRewPts, Setting $setting)
    {
        $this->rewardSettings = $rewardSettings;
        $this->custRewPts = $custRewPts;
        // $this->settings = $settings;
    }

    /**
     * Handle the event.
     *
     * @param OrderPlaced $event
     * @return void
     */
    public function handle(OrderPlaced $event)
    {
        
        if ($this->rewardSettings->isRewardPointEnabled()) {
            $rewardSettingsObj = new $this->rewardSettings;
            $epoint_forder_point_value = $rewardSettingsObj->getRewardPointsSettingValue('epoint_forder_point_value');
            $user = new User;

            if ($epoint_forder_point_value->epoint_forder_point_value > 0 && $user->isThisfirstOrder() <= 1) {
                $inserted_id  = $this->custRewPts->insertGetId([
                    'customer_id' => $event->order->customer_id,
                    'reward_type' => 'firstorder',
                    'order_id' => $event->order->id,
                    'reward_points_earned' => $epoint_forder_point_value->epoint_forder_point_value,
                    'expiry_date' =>  $this->rewardSettings->getRewardPointsExpiryDate()]);

                if ($inserted_id) {
                    Log::info('Listener Fired! First Order  inserted_id  - ' . $inserted_id . " - ***** ");
                }
            }

    }
}
}