<?php

namespace Modules\Fixedrate\Providers;

use Modules\Fixedrate\Admin\FixedrateTabs;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;
use Modules\Admin\Ui\Facades\TabManager;
use Modules\Fixedrate\Http\Controllers\FixedrateController;
use Mcamara\LaravelLocalization\Facades\LaravelLocalization;

class FixedrateServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        TabManager::register('fixedrates', FixedrateTabs::class);

        $this->registerFixedrateRoute();
    }

    private function registerFixedrateRoute()
    {
        $this->app->booted(function () {
            Route::get('{slug}', [FixedrateController::class, 'show'])
                ->prefix(LaravelLocalization::setLocale())
                ->middleware(['localize', 'locale_session_redirect', 'localization_redirect', 'web'])
                ->name('fixedrates.show');
        });
    }
}
