<?php

namespace Modules\Tax\Listeners;;

use FleetCart\Events\TaxEvent;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;

class MyTaxListener
{
    /**
     * Create the event listener.
     *
     * @return void
     */
    public function __construct()
    {
        //
    }

    /**
     * Handle the event.
     *
     * @param  \FleetCart\Events\TaxEvent  $event
     * @return void
     */
    public function handle(TaxEvent $event)
    {
        $data = $event->data;
    }
}
