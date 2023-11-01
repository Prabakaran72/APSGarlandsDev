<?php

namespace Modules\Customer\Http\Controllers\Admin;
use Modules\Support\Country;
use Modules\Customer\Entities\Customer;
use Modules\Admin\Traits\HasCrudActions;
use Modules\Customer\Http\Requests\SaveCustomerRequest;

class CustomerController
{
    use HasCrudActions;
    protected $countries;

    public function __construct()
    {
        $this->countries = Country::all();
    }
    /**
     * Model for the resource.
     *
     * @var string
     */
    protected $model = Customer::class;

    /**
     * Label of the resource.
     *
     * @var string
     */
    protected $label = 'customer::customers.customers';

    /**
     * View path of the resource.
     *
     * @var string
     */
    protected $viewPath = 'customer::admin.customers';

    /**
     * Form requests for the resource.
     *
     * @var array|string
     */
    protected $validation = SavecustomerRequest::class;
}
