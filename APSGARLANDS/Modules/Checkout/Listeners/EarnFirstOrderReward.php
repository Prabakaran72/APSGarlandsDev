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

class EarnFirstOrderReward
{
    /**
     * Create the event listener.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    /**
     * Handle the event.
     *
     * @param OrderPlaced $event
     * @return void
     */
    public function handle(OrderPlaced $event)
    {
        Log::info($event->order);

        if ($this->rewardSettings->isRewardPointEnabled()) {
            $rewardSettingsObj = new $this->rewardSettings;
            $epoint_forder_point_value = $rewardSettingsObj->getRewardPointsSettingValue('epoint_forder_point_value');
            
            if ($epoint_forder_point_value->epoint_forder_point_value >0 ) {
                $inserted_id  = $this->custRewPts->insertGetId([
                    'customer_id' => $event->user->id,
                    'reward_type' => 'firstorder',
                    'reward_points_earned' => $epoint_forder_point_value->epoint_forder_point_value,
                    'expiry_date' =>  $this->rewardSettings->getRewardPointsExpiryDate()]);

                if ($inserted_id) {
                    Log::info('Listener Fired!  inserted_id  - ' . $inserted_id . " - ***** ");
                    Log::info('Event User  - ' .$event->user->email. " - ***** ");
                    // try {

                    //     if (empty($rewardSettingsObj->getRewardPointsSettingValue('enable_show_points_by_mail'))) {
                    //         return;
                    //     }
                    //     Mail::to($event->user->email)
                    //         ->send(new RewardPointsEarnedMail($event->user->first_name));
                    // } catch (Swift_TransportException $e) {
                    //     //
                    // }
                }
            }

    }
}
}