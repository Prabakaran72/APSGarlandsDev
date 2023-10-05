<?php

namespace Modules\OrderSubscription\Http\Responses;

use Illuminate\Contracts\Support\Responsable;

class OrderSubscriptionTreeResponse implements Responsable
{
    /**
     * Categories collection.
     *
     * @var \Illuminate\Database\Eloquent\Collection
     */
    private $ordersubscriptions;

    /**
     * Create a new instance.
     *
     * @param \Illuminate\Database\Eloquent\Collection $ordersubscriptions
     */
    public function __construct($ordersubscriptions)
    {
        $this->ordersubscriptions = $ordersubscriptions;
    }

    /**
     * Create an HTTP response that represents the object.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function toResponse($request)
    {
        return response()->json($this->transform());
    }

    /**
     * Transform the ordersubscriptions.
     *
     * @return \Illuminate\Support\Collection
     */
    private function transform()
    {
        return $this->ordersubscriptions->map(function ($ordersubscription) {
            return [
                'id' => $ordersubscription->id,
                'parent' => $ordersubscription->parent_id ?: '#',
                'text' => $ordersubscription->name,
                'data' => [
                    'position' => $ordersubscription->position,
                ],
            ];
        });
    }
}
