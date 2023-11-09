<?php

namespace Modules\Pickupstore\Http\Controllers;

use Modules\Pickupstore\Entities\Pickupstore;
use Modules\Media\Entities\File;

class PickupstoreController
{
    /**
     * Display pickupstore for the slug.
     *
     * @param string $slug
     * @return \Illuminate\Http\Response
     */
    public function show($slug)
    {
       $logo = File::findOrNew(setting('storefront_header_logo'))->path;
       $pickupstore = Pickupstore::where('slug', $slug)->firstOrFail();

        return view('public.pickupstore.show', compact('pickupstore', 'logo'));
    }
    public function  getLocalPickupAddress(){
        $pickupstoreDetails = Pickupstore::all();
       // dd(response()->json($pickupstoreDetails));
        return response()->json($pickupstoreDetails);
        
      }
}
