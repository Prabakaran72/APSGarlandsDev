<?php

namespace Modules\Rewardpoints\Providers;

use Modules\Rewardpoints\Admin\RewardpointsTabs;
use Illuminate\Support\ServiceProvider;
use Modules\Admin\Ui\Facades\TabManager;

class RewardpointsServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap the application services.
     *
     * @return void
     */
    public function boot()
    {
        TabManager::register('rewardpoints', RewardpointsTabs::class);
    }
}