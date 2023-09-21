<?php

namespace Modules\Recurring\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Recurring\Entities\Recurring;


class RecurringController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Renderable
     */

     public function testindex()
    {
        if (auth()->id()) {
        return view('public.recurring.index');
        }else{
            return redirect()->route('login')->with('error', 'You are not authorized. Please Login and Try..!');
        }

    }
    public function showRecurringSlider()
    {
        $recurrings = Recurring::where('is_active',1)->get()->shuffle()->take(5);
        return view('public.recurring.recurring_slider', compact('recurrings'));
    }

    public function store(Request $request)
    {

        Recurring::create([
            'user_id' => auth()->id(),
            'user_name' => $request->name,
            'comment' => $request->comment,
            'is_active' =>  '0',

        ]);
        return redirect()->route('products.index')->with('success', 'recurring added successfully!');
        //return redirect()->route('account.recurrings.index');
        // return redirect()->route('products.index');
    }

 }
