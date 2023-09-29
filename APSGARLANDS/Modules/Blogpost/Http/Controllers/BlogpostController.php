<?php

namespace Modules\Blogpost\Http\Controllers;

use Modules\Blogpost\Entities\Blogpost;
use Modules\Media\Entities\File;

class BlogpostController
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
        $blogpost = Blogpost::where('slug', $slug)->firstOrFail();

        return view('public.blogposts.show', compact('blogpost', 'logo'));
    }
}
