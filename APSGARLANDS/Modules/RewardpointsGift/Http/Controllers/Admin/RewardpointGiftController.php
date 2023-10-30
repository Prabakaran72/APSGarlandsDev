<?php

namespace Modules\RewardpointsGift\Http\Controllers\Admin;

use Modules\RewardpointsGift\Entities\RewardpointsGift;
use Modules\Admin\Traits\HasCrudActions;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller;
use Modules\Core\Http\Requests\Request as RequestsRequest;
use Modules\Rewardpoints\Entities\Rewardpoints;
use Modules\RewardpointsGift\Entities\CustomerRewardPoint;
use Modules\User\Entities\User;
use Modules\RewardpointsGift\Http\Controllers\CustomerRewardpointController;
use Illuminate\Support\Facades\DB;

class RewardpointGiftController extends Controller
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
            // dd($this->getModel()->user()->isCustomer()->table($request));
            return $this->getModel()->table($request);
            // return $user->table($request);
        }
        return view("{$this->viewPath}.index");
    }


    public function show($id)
    {
        $entity = RewardpointsGift::where('user_id', $id)->get();
        $customer = User::find($id);

        if (request()->wantsJson()) {
            return $entity;
        }

        return view("{$this->viewPath}.show")->with(['rewardpointsgift' => $entity, 'customer' => $customer]);
    }


    public function edit($id)
    {
        $entity = RewardpointsGift::with('user')->find($id);


        if (request()->wantsJson()) {
            return $entity;
        }

        return view("{$this->viewPath}.edit")->with(['rewardpointsgifted' => $entity]);
    }



    public function update($id)
    {
        DB::beginTransaction();
        try {
            $entity = RewardpointsGift::find($id);
            $entity->update(
                $this->getRequest('update')->except(['_token', '_method'])
            );

            $customerEntity = CustomerRewardpoint::find($entity->customer_reward_id);
            $customerEntity->update(['reward_points_earned' => $entity->reward_point_value]);
            DB::commit();
            return redirect()->route("admin.rewardpointsgift.edit", $entity->user_id)
                ->withSuccess(trans('admin::messages.resource_saved', ['resource' => $this->getLabel()]));
        } catch (\Exception $e) {
            DB::rollBack();
            // throw $e; // Re-throw the exception to propagate it
            return redirect()->route("admin.rewardpointsgift.edit",$entity->user_id)->with('error', trans(
                'admin::messages.resource_save_failed',
                ['resource' => $this->getLabel()]
            ));
        }
    }

    public function create($id)
    {
        $user = User::find($id);
        return view("{$this->viewPath}.create")->with(['customer' => $user]);
    }

    public function store(Request $request)
    {
        DB::beginTransaction();
        try {
            $customer_id = request()->input('customer_id');
            $CustmerRewardPointsController = new CustomerRewardpointController();
            $expiry_date = $CustmerRewardPointsController->getRewardExpiaryTimeSpan();

            $customerrewardpoints = CustomerRewardPoint::create([
                'customer_id' => $customer_id,
                'reward_type' => 'manualoffer',
                'reward_points_earned' => request()->input('reward_point_value'),
                'reward_points_claimed' => request()->input('reward_points_claimed'),
                'expiry_date' => $expiry_date,
            ]);

            RewardpointsGift::create([
                'user_id' => $customer_id,
                'reward_point_value' => request()->input('reward_point_value'),
                'reward_point_remarks' => request()->input('reward_point_remarks'),
                'customer_reward_id' => $customerrewardpoints->id
            ]);

            // Commit the transaction if both inserts are successful
            DB::commit();
            return redirect()->route("admin.rewardpointsgift.edit", ['id' => $customer_id])
                ->withSuccess(trans('admin::messages.resource_saved', ['resource' => $this->getLabel()]));
        } catch (\Exception $e) {
            // Handle the exception (e.g., log it) and rollback the transaction
            DB::rollBack();
            // throw $e; // Re-throw the exception to propagate it
            return redirect()->route("admin.rewardpointsgift.edit", ['id' => $customer_id])->with('error', trans(
                'admin::messages.resource_save_failed',
                ['resource' => $this->getLabel()]
            ));
        }
    }
}
