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
}
