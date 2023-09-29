<?php

namespace Modules\Blogcategory\Http\Controllers;

use Modules\Blogcategory\Entities\Blogcategory;
use Modules\Media\Entities\File;

class BlogcategoryController
{
    /**
     * Display page for the slug.
     *
     * @param string $slug
     * @return \Illuminate\Http\Response
     */
    public function show($slug)
    {
        $logo = File::findOrNew(setting('storefront_header_logo'))->path;
        $blogcategory = Blogcategory::where('slug', $slug)->firstOrFail();

        return view('public.blogcategorys.show', compact('blogcategory', 'logo'));
    }
}
