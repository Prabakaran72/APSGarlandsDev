<?php

namespace Modules\User\Listeners;

use Modules\User\Events\CustomerRegistered;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Modules\Rewardpoints\Entities\Rewardpoints;
use Modules\RewardpointsGift\Entities\CustomerRewardPoint;
use Modules\Setting\Entities\Setting;
use Illuminate\Support\Facades\Log;
use Modules\User\Emails\RewardPointsEarnedMail;
use Illuminate\Support\Facades\Mail;
use Swift_TransportException;

class EarnRewardOnSignup
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
     * @param CustomerRegistered $event
     * @return void
     */
    public function handle(CustomerRegistered $event)
    {

        if ($this->rewardSettings->isRewardPointEnabled()) {
            $rewardSettingsObj = new $this->rewardSettings;
            $epoint_first_signup_value = $rewardSettingsObj->getRewardPointsSettingValue('epoint_first_signup_value');
            
            if ($epoint_first_signup_value->epoint_first_signup_value >0 ) {
                $inserted_id  = $this->custRewPts->insertGetId([
                    'customer_id' => $event->user->id,
                    'reward_type' => 'signup',
                    'reward_points_earned' => $epoint_first_signup_value->epoint_first_signup_value,
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
