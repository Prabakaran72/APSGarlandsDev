<?php

namespace Modules\Review\Events;

use Illuminate\Queue\SerializesModels;
use Modules\Review\Entities\Review;
class ReviewSubmitted
{
    use SerializesModels;

    /**
     * Create a new event instance.
     *
     * @return void
     */
    public $review;
    public function __construct(Review $review)
    {
        $this->review=$review;
    }

    /**
     * Get the channels the event should be broadcast on.
     *
     * @return array
     */
    public function broadcastOn()
    {
        return [];
    }
}
