<?php

namespace Modules\Account\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Testimonial\Entities\Testimonial;

class AccountTestimonialController extends Controller
{
    public function index()
    {
        $testimonials = auth()->user()
            ->testimonials()
            ->paginate(5);
        return view('public.account.testimonials.index', compact('testimonials'));
    }

    public function show($id)
    {
        $testimonials = auth()->user()
            ->testimonials()
            ->where('id', $id)
            ->firstOrFail();

        return view('public.account.testimonials.show', compact('testimonials'));
    }

    public function update(Request $request, $id)
    {
        // Retrieve the testimonial based on the provided ID
        $testimonial = Testimonial::findOrFail($id);

        // Update the comment field with the new value from the request
        $testimonial->comment = $request->input('comment');

        // Save the changes to the database
        $testimonial->save();

        // Redirect back or do something else upon successful update
        return redirect()->route('account.testimonials.index')
            ->with('success', 'Testimonial updated successfully');
    }
}
