<?php

namespace Modules\Testimonial\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Testimonial\Entities\Testimonial;


class TestimonialController extends Controller
{
    /**
     * Display a listing of the resource.
     * @return Renderable
     */

    public function testindex()
    {
        if (auth()->id()) {
            return view('public.testimonial.index');
        } else {
            return redirect()->route('login')->with('error', 'You are not authorized. Please Login and Try..!');
        }
    }

    

    public function showTestimonialSlider()
    {
        $testimonials = Testimonial::with('user')->where('is_active', 1)->take(5)->latest()->get();
        return view('public.testimonial.testimonial_slider', compact('testimonials'));
    }


    public function store(Request $request)
    {

        Testimonial::create([
            'user_id' => auth()->id(),
            'user_name' => $request->name,
            'comment' => $request->comment,
            'is_active' =>  '0',

        ]);
        return redirect()->route('products.index')->with('success', 'Testimonial added successfully!');
    }
}
