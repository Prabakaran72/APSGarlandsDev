<?php

namespace Modules\Pickupstore\Providers;

use Modules\Pickupstore\Admin\PickupstoreTabs;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;
use Modules\Admin\Ui\Facades\TabManager;
use Modules\Pickupstore\Http\Controllers\PickupstoreController;
use Mcamara\LaravelLocalization\Facades\LaravelLocalization;

class PickupstoreServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        TabManager::register('pickupstores', PickupstoreTabs::class);

        $this->registerPickupstoreRoute();
    }

    private function registerPickupstoreRoute()
    {
        $this->app->booted(function () {
            Route::get('{name}', [PickupstoreController::class, 'show'])
                ->prefix(LaravelLocalization::setLocale())
                ->middleware(['localize', 'locale_session_redirect', 'localization_redirect', 'web'])
                ->name('pickupstore.show');
        });
    }
}
