<?php

namespace Modules\Email\Http\Controllers;

use Modules\Email\Entities\Email;
use Modules\Media\Entities\File;

class EmailController
{
    /**
     * Display email for the slug.
     *
     * @param string $slug
     * @return \Illuminate\Http\Response
     */
    public function show($slug)
    {
        $logo = File::findOrNew(setting('storefront_header_logo'))->path;
        $email = Email::where('slug', $slug)->firstOrFail();

        return view('public.emails.show', compact('email', 'logo'));
    }
}
