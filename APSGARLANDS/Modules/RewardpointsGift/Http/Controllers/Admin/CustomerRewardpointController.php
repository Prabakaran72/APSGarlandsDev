<?php

namespace Modules\RewardpointsGift\Http\Controllers\Admin;


use Modules\RewardpointsGift\Entities\CustomerRewardPoint;
use Modules\Rewardpoints\Entities\Rewardpoints;
use Carbon\Carbon;
use Modules\Admin\Traits\HasCrudActions;
use DB;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\User\Entities\User;

class CustomerRewardpointController extends Controller
{
    use HasCrudActions;

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    protected $model = CustomerRewardPoint::class;
    // protected $label = 'rewardpointsgift::customerrewardpoints.customerrewardpoint';
    protected $viewPath = 'rewardpointsgift::admin.customerrewardpoint';
    public function index(Request $request)
    {
        if ($request->has('query')) {
            return $this->getModel()
                ->with['user']
                ->search($request->get('query'))
                ->query()
                ->limit($request->get('limit', 10))
                ->get();
        }

        if ($request->has('table')) {
            return $this->getModel()->table($request);

        }

        return view("{$this->viewPath}.index");
    }

    public function show($id)
    {
        $entity = CustomerRewardPoint::where('customer_id',$id)->get();
        $customer = User::find($id);      
        if (request()->wantsJson()) {
            return $entity;
        }

        return view("{$this->viewPath}.show")->with(['customerrewardpoint' => $entity, 'customer'=> $customer]);
    }

    function getexpiredRewardpoints(){
        //$expired_earned_rewardpoints => User earned rewardpoints, but expired
        //$expired_claimed_rewardpoints => User claimed rewardpoints before expiry but on current date,earned rewardpoints expired
        //expired_points = $expired_earned_rewardpoints - $expired_claimed_rewardpoints


    }

    public function create( $request = null , $reward_type = null)
    {
        
        $customerRewardPoints = new $this->model();
        $getRewardExpiaryTimeSpan = $this->getRewardExpiaryTimeSpan();    
        if( $reward_type =='manualoffer'){
            $customerRewardPoints->customer_id = $request->user_id;
            $customerRewardPoints->reward_type =$reward_type;
            $customerRewardPoints->reward_points_earned = $request->reward_point_value;
            $customerRewardPoints->expiry_date = $getRewardExpiaryTimeSpan;
            $customerRewardPoints->updated_at = Carbon::now();
            $customerRewardPoints->created_at = Carbon::now();
            $customerRewardPoints->save();
        }
    }
    // public function update($request = null, $reward_type = null)
    // {
    //     $customerRewardPoints = $this->model::where('customer_id',$request->user_id)->where("reward_type", $reward_type)->latest()->get();
    //     dd($customerRewardPoints);
    //     $getRewardExpiaryTimeSpan = $this->getRewardExpiaryTimeSpan();

    //     if( $reward_type =='manual'){
    //         // $customerRewardPoints->customer_id = $request->user_id;
    //         $customerRewardPoints->reward_type = $reward_type;
    //         $customerRewardPoints->reward_points_earned = $request->reward_point_value;
    //         $customerRewardPoints->expiry_date = $request->$getRewardExpiaryTimeSpan;
    //         $customerRewardPoints->updated_at = Carbon::now();
    //         $customerRewardPoints->save();
    //     }
    // }

    public function getRewardExpiaryTimeSpan()
    {
        $rewardpoints_setting = Rewardpoints::first();
        $numdays = $rewardpoints_setting->getRewardPointsExpirationDays();
        return Carbon::now()->addDays($numdays->add_days_reward_points_expiry);       
    }
}
