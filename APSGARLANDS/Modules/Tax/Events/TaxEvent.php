<?php

namespace Modules\Tax\Events;


use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class TaxEvent
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $data;

    /**
     * Create a new event instance.
     *
     * @return void
     */
    public function __construct($data)
    {
        $this->data = $data;
    }
   
}
