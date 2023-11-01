<?php

namespace Modules\OrderSubscription\Providers;

use Modules\Support\Traits\AddsAsset;
use Illuminate\Support\ServiceProvider;

class OrderSubscriptionServiceProvider extends ServiceProvider
{
    use AddsAsset;

    /**
     * Bootstrap the application services.
     *
     * @return void
     */
    public function boot()
    {
       
        $this->addAdminAssets('admin.ordersubscription.index', [
            'admin.ordersubscription.css', 'admin.jstree.js', 'admin.ordersubscription.js',
            'admin.media.css', 'admin.media.js',
        ]);
    }
}
