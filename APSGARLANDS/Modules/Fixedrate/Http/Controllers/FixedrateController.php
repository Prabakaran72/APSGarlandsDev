<?php

namespace Modules\Fixedrate\Http\Controllers;

use Modules\Fixedrate\Entities\Fixedrate;
use Modules\Media\Entities\File;

class FixedrateController
{
    /**
     * Display fixedrate for the slug.
     *
     * @param string $slug
     * @param string $pincode 
     * @param string $newZip 
     * @return \Illuminate\Http\Response
     */
    public function show($slug)
    {
        $logo = File::findOrNew(setting('storefront_header_logo'))->path;
        $fixedrate = Fixedrate::where('slug', $slug)->firstOrFail();

        return view('public.fixedrates.show', compact('fixedrate', 'logo'));
    }
    // public function getPincode($pincode)
    // {
    //     $pincodeData = FixedRate::where('pincode', $pincode)->first();
    
    //     if ($pincodeData) {
    //         return response()->json(['pincode' => $pincodeData->pincode]);
    //     }
        
    //     return response()->json(['pincode' => null]);
    //   echo "welcome". response()->json(['pincode' => null]);
    // }
    // public function getFixedrates($newZip)
    // {
    //     $pincodeData = Fixedrate::where('pincode', $newZip)->first();

    //     if ($pincodeData) {
    //         return response()->json(['flat_price' => $pincodeData->flat_price]);
    //     }

    //     return response()->json(['flat_price' => null]);
    // }
}
