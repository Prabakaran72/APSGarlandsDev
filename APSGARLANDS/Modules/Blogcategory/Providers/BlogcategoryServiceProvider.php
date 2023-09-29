<?php

namespace Modules\Blogcategory\Providers;

use Modules\Blogcategory\Admin\BlogcategoryTabs;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;
use Modules\Admin\Ui\Facades\TabManager;
use Modules\Blogcategory\Http\Controllers\BlogcategoryController;
use Mcamara\LaravelLocalization\Facades\LaravelLocalization;

class BlogcategoryServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        TabManager::register('blogcategorys', BlogcategoryTabs::class);

        $this->registerBlogcategoryRoute();
    }

    private function registerBlogcategoryRoute()
    {
        $this->app->booted(function () {
            Route::get('{slug}', [BlogcategoryController::class, 'show'])
                ->prefix(LaravelLocalization::setLocale())
                ->middleware(['localize', 'locale_session_redirect', 'localization_redirect', 'web'])
                ->name('blogcategorys.show');
        });
    }
}
