<?php

namespace Modules\Customer\Http\Controllers;

use Modules\Customer\Entities\Customer;
use Modules\Media\Entities\File;

class CustomerController
{
    /**
     * Display customer for the slug.
     *
     * @param string $slug
     * @return \Illuminate\Http\Response
     */
    public function show($slug)
    {
        $logo = File::findOrNew(setting('storefront_header_logo'))->path;
        $customer = Customer::where('slug', $slug)->firstOrFail();

        return view('public.customers.show', compact('customer', 'logo'));
    }
    public function getcountry()
{
    $items = Item::all();

    return view('your.blade.view', compact('items'));
}
}
 