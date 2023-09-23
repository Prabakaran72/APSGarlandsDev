<?php

namespace Modules\Recurring\Http\Controllers\admin;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Recurring\Entities\Recurring;
use Modules\Recurring\Entities\recurringMainOrder;
use Modules\Recurring\Entities\RecurringSubOrder;
use Modules\User\Entities\User;
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
       $created_id = $recurring_main_order->created_id;

       
       $user = User::find($created_id);
       $user_first_name = $user->first_name;
       $user_last_name = $user->last_name;
       $user_email = $user->email;

       return view('recurring::admin.recurrings.edit', compact('id', 'recurring_main_order','user_first_name','user_last_name','user_email'));
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
