<?php

namespace Modules\Galleries\Http\Controllers;

use Illuminate\Contracts\Support\Renderable;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Galleries\Entities\Galleries;

class GalleriesController extends Controller {
    /**
     * Display a listing of the resource.
     * @return Renderable
     */

    public function testindex() {
        return view('public.galleries.index');
    }

    public function showGallerySlider() {
        $galleries = Galleries::where('is_active',1)->get()->shuffle()->take(5);
        return view('public.galleries.galleries_slider', compact('galleries'));
    }
}
