<?php

namespace Modules\Fixedrate\Http\Controllers;

use Modules\Fixedrate\Entities\Fixedrate;
use Modules\Media\Entities\File;
use Illuminate\Support\Facades\Session;
use Illuminate\Http\Request;
use Modules\Cart\Facades\Cart;

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
    public function getpincode()
    {
        $pincodeData = Fixedrate::all(['pincode', 'flat_price']);

        if ($pincodeData->isNotEmpty()) {
            // Prepare an associative array where the pincode is the key and flat_price is the value
            $pincodePriceMap = $pincodeData->pluck('flat_price', 'pincode')->toArray();

            return response()->json($pincodePriceMap);
        }

        return response()->json([]); // Return an empty array if there is no data

    }
    public function getfixedrates(Request $request)
    {
        $dynamicFlatRateCost = $request->input('price');

        // Store the dynamic flat rate cost in the session
        Session::put('dynamic_flat_rate_cost', $dynamicFlatRateCost);

        return response()->json(['flat_rate_cost' => $dynamicFlatRateCost]);
    }

    public function updateFlatRateAmount(Request $request){
        // dd($request->FlatRateAmount);
        Cart::storeFlatRateAmount($request->FlatRateAmount);
        return Cart::instance();
    }
}
