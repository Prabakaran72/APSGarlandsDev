<?php

namespace Modules\Blogcategory\Http\Controllers;

class HomeController
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('public.home.index');
    }
}
