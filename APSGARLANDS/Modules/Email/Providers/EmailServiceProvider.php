<?php

namespace Modules\Email\Providers;

use Modules\Email\Admin\EmailTabs;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;
use Modules\Admin\Ui\Facades\TabManager;
use Modules\Email\Http\Controllers\EmailController;
use Mcamara\LaravelLocalization\Facades\LaravelLocalization;

class EmailServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        TabManager::register('emails', EmailTabs::class);

        $this->registerEmailRoute();
    }

    private function registerEmailRoute()
    {
        $this->app->booted(function () {
            Route::get('{slug}', [EmailController::class, 'show'])
                ->prefix(LaravelLocalization::setLocale())
                ->middleware(['localize', 'locale_session_redirect', 'localization_redirect', 'web'])
                ->name('emails.show');
        });
    }
}
