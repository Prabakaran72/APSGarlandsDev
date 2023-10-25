<?php

namespace Modules\Galleries\Providers;

use Illuminate\Support\Facades\View;
use Modules\Support\Traits\AddsAsset;
use Illuminate\Support\ServiceProvider;
use Modules\Admin\Http\ViewComposers\AssetsComposer;

class GalleriesServiceProvider extends ServiceProvider
{
    use AddsAsset;

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        View::composer('galleries::admin.file_manager.index', AssetsComposer::class);

        $this->addAdminAssets('admin.(galleries|file_manager).(index|edit)', ['admin.galleries.css', 'admin.galleries.js']);
    }
}
