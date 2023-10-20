<?php

namespace Modules\Subscriber\Http\Controllers;

use Modules\Subscriber\Entities\Subscriber;
use Modules\Media\Entities\File;
use Newsletter;
use Modules\Newsletter\Http\Requests\StoreSubscriberRequest;
use Illuminate\Http\Request;
class SubscriberController
{
    /**
     * Display subscriber for the slug.
     *
    //  * @param string $slug
    //  * @return \Illuminate\Http\Response
    //  */
    // public function show($slug)
    // {
    //     $logo = File::findOrNew(setting('storefront_header_logo'))->path;
    //     $subscriber = Subscriber::where('slug', $slug)->firstOrFail();

    //     return view('public.subscribers.show', compact('subscriber', 'logo'));
    // }
    // public function store(StoreSubscriberRequest $request)
    // { 
    //     $email = $request->input('email');
    
    //     // Check if the email already exists in the subscribers table
    //     $existingSubscriber = Subscriber::where('email', $email)->first();
    
    //     if (!$existingSubscriber) {
    //         // If the email doesn't exist, create a new subscriber record with 'is_active' set to true
    //         Subscriber::create([
    //             'email' => $email,
    //             'is_active' => true, // Set 'is_active' to true for new subscribers
    //             // You can set other attributes here as needed
    //         ]);
    //     }
        
    //     // Newsletter::subscribeOrUpdate($request->email);
    
    //     // if (!Newsletter::lastActionSucceeded()) {
    //     //     return response()->json([
    //     //         'message' => str_after(Newsletter::getLastError(), '400: '),
    //     //     ], 403);
    //     // }
    // }

    public function store(StoreSubscriberRequest $request)
    {      
        $email = $request->input('email');          
        $subscribe = Newsletter::subscribeOrUpdate($email);

        if(!$subscribe){    
            if(! Newsletter::lastActionSucceeded()) {                
                return response()->json([
                    'message' => str_after(Newsletter::getLastError(), '400: '),
                ], 403);   
            }                           
        }                                 
        else {
                // Find the existing subscriber by email
                $existingSubscriber = Subscriber::where('email', $email)->first();
                
                // dd($existingSubscriber);
                if (!$existingSubscriber) {
                    // If the email doesn't exist, create a new subscriber record with 'is_active' set to true

                    Subscriber::create([
                        'email' => $email,
                        'is_active' => true,
                        // You can set other attributes here as needed
                    ]);           
            
                    return $subscribe['id'];  
                    // return response()->json([
                    //     'message' => 'new',
                    // ]);
                } else {
                
                    // dd('fail');
                    // If the subscriber exists but is not active, update 'is_active' to true
                    if ($existingSubscriber->is_active) {
                    
                        return response()->json([
                            'message' => 'already_subscribed',
                        ]);
                    } else {
                        // Subscriber already exists and is active                
                        $existingSubscriber->is_active = true;
                        $existingSubscriber->save();
            
                        return response()->json([
                            'message' => 'subscription_enabled',
                        ]);
                    }
                }        
            
            
        }               
    }
   
    public function delete(Request $request)
    {
        // Get the email from the form input
        $email = $request->input('email');

        // Find the subscriber by email
        $subscriber = Subscriber::where('email', $email)->first();

        if ($subscriber) {
            // If the subscriber exists, delete it
            $subscriber->delete();

            // return response()->json([
                return redirect()->route('unsubscribe')->with('success', 'Unsubscribed successfully!');
            //     'message' => 'unsubscribe_success',
            // ]);
        } else {
            // Subscriber not found, return an error response
            return redirect()->route('unsubscribe')->with('error', 'subscriber not found!');
            // return response()->json([
            //     'message' => 'subscriber_not_found',
            // ], 404);
        }
    }
    public function unsubscribe()
    {
        // if (auth()->id()) {
        return view('public.unsubscribe.index');
        // }else{
        //     return redirect()->route('login')->with('error', 'You are not authorized. Please Login and Try..!');
        // }

    }
}
