<?php

namespace Modules\Blogtag\Http\Controllers;

use Modules\Blogtag\Entities\Blogtag;
use Modules\Media\Entities\File;

class BlogtagController
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
        $blogtag = Blogtag::where('slug', $slug)->firstOrFail();

        return view('public.blogtags.show', compact('blogtag', 'logo'));
    }
}
