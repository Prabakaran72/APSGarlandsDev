<?php

namespace Modules\Review\Providers;

use Illuminate\Foundation\Support\Providers\EventServiceProvider as ServiceProvider;

class EventServiceProvider extends ServiceProvider
{
    /**
     * The event listener mappings for the application.
     *
     * @var array
     */
    protected $listen = [
        \Modules\Checkout\Events\ReviewSubmitted::class => [
            \Modules\Checkout\Listeners\EarnFirstReview::class,
        ],
    ];
}
