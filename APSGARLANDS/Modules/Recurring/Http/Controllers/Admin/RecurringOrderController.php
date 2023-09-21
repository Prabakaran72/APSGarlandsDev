<?php

namespace Modules\Recurring\Http\Controllers\admin;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Recurring\Entities\Recurring;
use Modules\Recurring\Entities\RecurringSubOrder;
use Modules\Order\Entities\order;
use Illuminate\Support\Facades\Response;

class RecurringOrderController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Renderable
     */
    public function index()
    {
        return view('recurring::index');
    }

    /**
     * Show the form for creating a new resource.
     * @return Renderable
     */
    public function create()
    {
        return view('recurring::create');
    }

    /**
     * Store a newly created resource in storage.
     * @param Request $request
     * @return Renderable
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Show the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function show($id)
    {
        return view('recurring::show');
    }

    /**
     * Show the form for editing the specified resource.
     * @param int $id
     * @return Renderable
     */
    public function edit($id)
    {

        $recurring_main_order = Recurring::with('recurring_sub_datas')->whereId($id)->first();
        $recurring_sub_orders = RecurringSubOrder::where('recurring_id', $recurring_main_order->id)->get();

        // Convert the main order data to an associative array
        $mainOrderData = [
            'customer_id' => $recurring_main_order->customer_id,
            'delivery_time' => $recurring_main_order->delivery_time,
            'main_created_at' => $recurring_main_order->created_at,
            // Add more fields from the main order table as needed
        ];

        // Convert the sub order data to an array of associative arrays
        $subOrderData = $recurring_sub_orders->map(function ($subOrder) {
            return [
                'recurring_id' => $subOrder->recurring_id,
                'order_id' => $subOrder->order_id,
                'order_date' => $subOrder->order_date,
                'delivery_date' => $subOrder->delivery_date,
                // Add more fields from the sub order table as needed
            ];
        });

        // Pass both sets of data to the view
        return view('recurring::admin.recurrings.edit', compact('id', 'mainOrderData', 'subOrderData'));

        // $recurring_main_order = Recurring::with('recurring_sub_datas')->whereId($id)->first();
        // $jsonResponse = Response::json($recurring_main_order)->getContent(); // Get the JSON content

        // // Decode the JSON response to an associative array
        // $dataArray = json_decode($jsonResponse, true);

        // // Pass the data to the view
        // return view('recurring::admin.recurrings.edit', compact('id', 'dataArray'));
    }

    /**
     * Update the specified resource in storage.
     * @param Request $request
     * @param int $id
     * @return Renderable
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     * @param int $id
     * @return Renderable
     */
    public function destroy($id)
    {
        //
    }
}
