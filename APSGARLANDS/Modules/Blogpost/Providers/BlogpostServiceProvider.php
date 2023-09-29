<?php

namespace Modules\Blogpost\Providers;

use Modules\Blogpost\Admin\BlogpostTabs;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;
use Modules\Admin\Ui\Facades\TabManager;
use Modules\Blogpost\Http\Controllers\BlogpostController;
use Mcamara\LaravelLocalization\Facades\LaravelLocalization;

class BlogpostServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        TabManager::register('blogposts', BlogpostTabs::class);

        $this->registerBlogpostRoute();
    }

    private function registerBlogpostRoute()
    {
        $this->app->booted(function () {
            Route::get('{slug}', [BlogpostController::class, 'show'])
                ->prefix(LaravelLocalization::setLocale())
                ->middleware(['localize', 'locale_session_redirect', 'localization_redirect', 'web'])
                ->name('blogposts.show');
        });
    }
}
