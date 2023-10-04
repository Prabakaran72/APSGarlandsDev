<?php

namespace Modules\Recurring\Providers;

use Modules\Recurring\Admin\RecurringTabs;
use Illuminate\Support\ServiceProvider;
use Modules\Admin\Ui\Facades\TabManager;

class RecurringServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap the application services.
     *
     * @return void
     */
    public function boot()
    {
        TabManager::register('recurrings', RecurringTabs::class);
    }
}
