<?php

namespace Modules\Account\Http\Controllers;

class AccountRewardpointsController
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
       
        $rewardpoints = auth()->user()
            ->customerRewardPoints()
            ->paginate(10);

        return view('public.account.rewardpoints.index', compact('rewardpoints'));
    }
}
