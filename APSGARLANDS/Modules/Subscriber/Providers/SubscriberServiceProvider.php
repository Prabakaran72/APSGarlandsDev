<?php

namespace Modules\Subscriber\Providers;

use Modules\Subscriber\Admin\SubscriberTabs;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\ServiceProvider;
use Modules\Admin\Ui\Facades\TabManager;
use Modules\Subscriber\Http\Controllers\SubscriberController;
use Mcamara\LaravelLocalization\Facades\LaravelLocalization;

class SubscriberServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        // if (config('app.installed')) {
        //     $this->app['config']->set('newsletter.apiKey', setting('mailchimp_api_key'));
        //     $this->app['config']->set('newsletter.lists.subscribers.id', setting('mailchimp_list_id'));
        // }
        TabManager::register('subscribers', SubscriberTabs::class);

        $this->registerSubscriberRoute();
   
        if (config('app.installed')) {
            $this->app['config']->set('newsletter.apiKey', setting('mailchimp_api_key'));
            $this->app['config']->set('newsletter.lists.subscribers.id', setting('mailchimp_list_id'));
        }
    }
    private function registerSubscriberRoute()
    {
        // $this->app->booted(function () {
        //     Route::get('{slug}', [SubscriberController::class, 'show'])
        //         ->prefix(LaravelLocalization::setLocale())
        //         ->middleware(['localize', 'locale_session_redirect', 'localization_redirect', 'web'])
        //         ->name('subscribers.show');
        // });
    }
}
