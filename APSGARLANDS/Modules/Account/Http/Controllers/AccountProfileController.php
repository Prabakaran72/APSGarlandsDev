<?php

namespace Modules\Account\Http\Controllers;

use Modules\User\Http\Requests\UpdateProfileRequest;

class AccountProfileController
{
    /**
     * Show the form for editing the specified resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function edit()
    {
        return view('public.account.profile.edit', [
            'account' => auth()->user(),
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Modules\User\Http\Requests\UpdateProfileRequest $request
     * @return \Illuminate\Http\Response
     */
    public function update(UpdateProfileRequest $request)
    {
        $request->validate([
            'image_url' => 'required|image|mimes:png,jpg|max:2048',
        ]);
    $user_id = auth()->user()->id; 
    $directoryPath = public_path("/storage/profile/{$user_id}");
    if (!file_exists($directoryPath)) {
        mkdir($directoryPath, 0755, true);
    }
    $image=$request->file('image_url');

    $fileExtension = $image->getClientOriginalExtension();

    $filename = uniqid() . '.' .$fileExtension;
    $request->file('image_url')->move($directoryPath, $filename);
    $request->bcryptPassword($request);
    if($request->hasFile('image_url')){
    $image_url = "storage/profile/{$user_id}/{$filename}";
    }else{
       $image_url = '';
    }
    
    auth()->user()->update([$request->all(),'image_url'=>$image_url]);

    return back()->with('success', trans('account::messages.profile_updated'));
    }
}
