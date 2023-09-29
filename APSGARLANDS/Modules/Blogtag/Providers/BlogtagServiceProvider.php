<?php

namespace Modules\Blogtag\Providers;

use Modules\Blogtag\Admin\BlogtagTabs;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;
use Modules\Admin\Ui\Facades\TabManager;
use Modules\Blogtag\Http\Controllers\BlogtagController;
use Mcamara\LaravelLocalization\Facades\LaravelLocalization;

class BlogtagServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        TabManager::register('blogtags', BlogtagTabs::class);

        $this->registerBlogtagRoute();
    }

    private function registerBlogtagRoute()
    {
        $this->app->booted(function () {
            Route::get('{slug}', [BlogtagController::class, 'show'])
                ->prefix(LaravelLocalization::setLocale())
                ->middleware(['localize', 'locale_session_redirect', 'localization_redirect', 'web'])
                ->name('blogtags.show');
        });
    }
}
