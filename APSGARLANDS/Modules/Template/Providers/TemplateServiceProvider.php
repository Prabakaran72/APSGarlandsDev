<?php

namespace Modules\Template\Providers;

use Modules\Template\Admin\TemplateTabs;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;
use Modules\Admin\Ui\Facades\TabManager;
use Modules\Template\Http\Controllers\TemplateController;
use Mcamara\LaravelLocalization\Facades\LaravelLocalization;

class TemplateServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        TabManager::register('templates', TemplateTabs::class);

        $this->registerTemplateRoute();
    }

    private function registerTemplateRoute()
    {
        // $this->app->booted(function () {
        //     Route::get('{slug}', [TemplateController::class, 'show'])
        //         ->prefix(LaravelLocalization::setLocale())
        //         ->middleware(['localize', 'locale_session_redirect', 'localization_redirect', 'web'])
        //         ->name('templates.show');
        // });
    }
}
