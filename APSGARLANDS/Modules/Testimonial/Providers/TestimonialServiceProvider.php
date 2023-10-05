<?php

namespace Modules\Testimonial\Providers;

use Modules\Testimonial\Admin\TestimonialTabs;
use Illuminate\Support\ServiceProvider;
use Modules\Admin\Ui\Facades\TabManager;

class TestimonialServiceProvider extends ServiceProvider
{
    /**
     * Bootstrap the application services.
     *
     * @return void
     */
    public function boot()
    {
        TabManager::register('testimonials', TestimonialTabs::class);
    }
}
