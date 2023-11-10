<?php

namespace Modules\Review\Listeners;

use Modules\Review\Events\ReviewSubmitted;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Modules\Rewardpoints\Entities\Rewardpoints;
use Modules\RewardpointsGift\Entities\CustomerRewardPoint;
use Modules\Setting\Entities\Setting;
use Illuminate\Support\Facades\Log;
use Modules\User\Emails\RewardPointsEarnedMail;
use Illuminate\Support\Facades\Mail;
use Modules\User\Entities\User;

class EarnFirstReview
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
     * @param ReviewSubmitted $event
     * @return void
     */
    public function handle(ReviewSubmitted $event)
    {
        dd('from Listener');
        if ($this->rewardSettings->isRewardPointEnabled()) {
            // $rewardSettingsObj = new $this->rewardSettings;
            $epoint_freview_point_value = $this->rewardSettings->getRewardPointsSettingValue('epoint_freview_point_value');
            $user = new User;

            if ($epoint_freview_point_value->epoint_freview_point_value > 0 && $user->isThisfirstReview() == 1) {
                $inserted_id  = $this->custRewPts->insertGetId([
                    'customer_id' => $event->review->reviewer_id,
                    'reward_type' => 'firstreview',
                    'order_id' => $event->review->id,
                    'reward_points_earned' => $epoint_freview_point_value->epoint_freview_point_value,
                    'expiry_date' =>  $this->rewardSettings->getRewardPointsExpiryDate()]);

                if ($inserted_id) {
                    Log::info('Listener Fired! First RMS PAYMENT  inserted_id  - ' . $inserted_id . " - ***** ");
                }
            }
    }
}
}