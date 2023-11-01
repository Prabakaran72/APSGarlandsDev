<?php

namespace Modules\Template\Http\Controllers;

use Modules\Template\Entities\Template;
use Modules\Media\Entities\File;

class TemplateController
{
    /**
     * Display template for the slug.
     *
     * @param string $slug
     * @return \Illuminate\Http\Response
     */
    public function show($slug)
    {
        $logo = File::findOrNew(setting('storefront_header_logo'))->path;
        $template = Template::where('slug', $slug)->firstOrFail();

        return view('public.templates.show', compact('template', 'logo'));
    }
    // Import the Template model

    public function getTemplate($slug)
{
    // Retrieve template data based on the slug (assuming 'slug' is a field in the Template model)
    $template = Template::where('slug', $slug)->firstOrFail();

    return view('public.emails.index', [
        'template' => $template, // Pass the template data to the view
    ]);
}

}
