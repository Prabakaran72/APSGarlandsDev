<?php

namespace Modules\Customer\Providers;

use Modules\Customer\Admin\CustomerTabs;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;
use Modules\Admin\Ui\Facades\TabManager;
use Modules\Customer\Http\Controllers\CustomerController;
use Mcamara\LaravelLocalization\Facades\LaravelLocalization;

class CustomerServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        TabManager::register('customers', CustomerTabs::class);

        $this->registerCustomerRoute();
    }

    private function registerCustomerRoute()
    {
        $this->app->booted(function () {
            Route::get('{slug}', [      CustomerController::class, 'show'])
                ->prefix(LaravelLocalization::setLocale())
                ->middleware(['localize', 'locale_session_redirect', 'localization_redirect', 'web'])
                ->name('customers.show');
        });
    }
}
