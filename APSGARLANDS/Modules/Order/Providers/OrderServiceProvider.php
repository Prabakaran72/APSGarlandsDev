<?php

namespace Modules\Order\Providers;

use Modules\Support\Traits\AddsAsset;
use Illuminate\Support\ServiceProvider;
use Modules\Order\Admin\OrderTabs;
use Modules\Admin\Ui\Facades\TabManager;

class OrderServiceProvider extends ServiceProvider
{
    use AddsAsset;

    /**
     * Bootstrap the application services.
     *
     * @return void
     */
    public function boot()
    {
        TabManager::register('orders', OrderTabs::class);
        $this->addAdminAssets('admin.orders.show', ['admin.order.css', 'admin.order.js']);
    }
}
