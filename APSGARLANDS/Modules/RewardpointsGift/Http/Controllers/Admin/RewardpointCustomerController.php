<?php

namespace Modules\RewardpointsGift\Http\Controllers\Admin;

use Modules\RewardpointsGift\Entities\RewardpointsGift;
use Modules\Admin\Traits\HasCrudActions;
use Modules\RewardpointGift\Http\Requests\SaveTagRequest;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Rewardpoints\Entities\Rewardpoints;
use Modules\User\Entities\User;
use Modules\RewardpointsGift\Http\Controllers\CustomerRewardpointController;


class RewardpointCustomerController extends Controller
{
    use HasCrudActions;

    /**
     * Model for the resource.
     *
     * @var string
     */
    protected $model = RewardpointsGift::class;


    /**
     * Label of the resource.
     *
     * @var string
     */
    protected $label = 'rewardpointsgift::rewardpointsgifts.rewardpointsgift';

    /**
     * View path of the resource.
     *
     * @var string
     */
    protected $viewPath = 'rewardpointsgift::admin.rewardpointsgift';


    public function index(Request $request)
    {
        if ($request->has('query')) {
            return $this->getModel()
                ->with['rewardpointsgift']
                ->search($request->get('query'))
                ->query()
                ->limit($request->get('limit', 10))
                ->get();
        }

        if ($request->has('table')) {
            return $this->getModel()->customertable($request);
        }
        
        return view("{$this->viewPath}.show");
    }


    // public function show(Request $request, $id)
    // {
    //     $entity = RewardpointsGift::find($id);

    //     // if (request()->wantsJson()) {
    //     //     return $entity;
    //     // }

    //     if ($request->has('query')) {
    //         return $this->getModel()
    //             ->with['rewardpointsgift']
    //             ->search($request->get('query'))
    //             ->query()
    //             ->limit($request->get('limit', 10))
    //             ->get();
    //     }

    //     if ($request->has('table')) {
    //         return $this->getModel()->customertable($id);
    //     }

    //     return view("{$this->viewPath}.show")->with(['rewardpointsgift' => $entity->rewardpointsgift, 'customer'=> $entity]);
    // }


    // public function edit($id)
    // {
    //     $rewardpointsgifted = RewardpointsGift::select('id')->where('user_id',$id)->first();
        
    //     $entity = User::with('rewardpointsgift')->find($id);
    //     // $entity = $entity->user;   returns corresponding user
    //     // dd($entity);
    //     if (request()->wantsJson()) {
    //         return $entity;
    //     }
    //     return view("{$this->viewPath}.edit")->with(['rewardpointsGift' => $entity->rewardpointsgift, 'customer'=> $entity]);
    // }



    // public function update($id)
    // {
    //     $rewardpointsgifted = RewardpointsGift::select('id')->where('user_id',$id)->first();
        
    //     $this->disableSearchSyncing();
    //     $entity = null;
    //     if($rewardpointsgifted == null)
    //     {
    //         $entity = new RewardpointsGift();
            
    //         $entity->user_id = $id;
    //         $entity->reward_point_remarks = $this->getRequest('update')->reward_point_remarks;
    //         $entity->reward_point_value = $this->getRequest('update')->reward_point_value;
    //         $entity->save();
    //         // $CustmerRewardPointsController = new CustomerRewardpointController();
    //         // $CustmerRewardPointsController->create($entity,'manualoffer');
    //     }
    //     else{
    //         $entity = $this->getEntity($rewardpointsgifted->id);
    //         $entity->update(
    //             $this->getRequest('update')->except(['_token','_method'])
    //         );
    //         // $CustmerRewardPointsController = new CustomerRewardpointController();
    //         // $CustmerRewardPointsController->update($entity,'manual');
    //         $entity->user_id = $id;
    //     }
        
    //     $CustmerRewardPointsController = new CustomerRewardpointController();
    //     $CustmerRewardPointsController->create($entity,'manualoffer');
    //     $this->searchable($entity);

    //     if (method_exists($this, 'redirectTo')) {
    //         return $this->redirectTo($entity)
    //             ->withSuccess(trans('admin::messages.resource_saved', ['resource' => $this->getLabel()]));
    //     }

    //     return redirect()->route("admin.rewardpointsgift.index")
    //         ->withSuccess(trans('admin::messages.resource_saved', ['resource' => $this->getLabel()]));
    // }

    // public function updateCustomerRewards($request)
    // {
    //     dd($request);
    // }
}
