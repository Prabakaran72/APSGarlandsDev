<?php

namespace Modules\Wishlist\Http\Controllers;

use Illuminate\Support\Facades\DB;


class WishlistController
{
    /**
     * Store a newly created resource in storage.
     *
     * @return \Illuminate\Http\Response
     */


     //OLD Method - it's working fine
    // public function store()
    // {
    //     if (! auth()->user()->wishlistHas(request('productId'))) {
    //         auth()->user()->wishlist()->attach(request('productId'));
           
    //     }
    // }

    public function store()
    {
        $productId = request('productId');
        $reason = null; // Set reason to null by default

        $attributes = [
            'user_id' => auth()->id(),
            'product_id' => $productId,
        ];

        $values = [
            'is_deleted' => '0',
            'reason' => $reason,
            'created_at' => now(),
            'updated_at' => now(),
        ];

        \DB::table('wish_lists')->updateOrInsert($attributes, $values);
        
        return response()->json(['message' => 'Product added to wishlist successfully']);
    }





    /**
     * Destroy resources by the given id.
     *
     * @param string $productId
     * @return void
     */

    // public function destroy($productId)
    // {
    //     auth()->user()->wishlist()->detach($productId);
    // }     


    public function destroySelectedDatas($productsDataId)
    {                                       
            $getReason = request('getReason');

            // Split the comma-separated values into an array
            $productIds = explode(',', $productsDataId);

            // Loop through each product ID and update the pivot table
            foreach ($productIds as $productId) {
                auth()->user()->wishlist()->updateExistingPivot($productId, [
                    'is_deleted' => '1',
                    'reason' => $getReason,
                ]);
            }
            
        return response()->json(['message' => 'Products deleted successfully']);
    }




    public function destroy($productId)
    {                       
        $proData = request('proData');
    
        // Check if $proData is not null and not empty
        if (!is_null($proData) && !empty($proData)) {
            // Use $proData in the updateExistingPivot call
            $clear = auth()->user()->wishlist()->updateExistingPivot($productId, [
                'is_deleted' => '1',
                'reason' => $proData,
            ]);
        } else {
            // Handle the case where $proData is null or empty
            // This is optional and depends on your application logic
        }
    
        return $clear;  
    }



   

}
