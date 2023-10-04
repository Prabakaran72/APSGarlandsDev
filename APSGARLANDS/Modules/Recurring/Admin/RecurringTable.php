<?php

namespace Modules\Recurring\Admin;

use Modules\Admin\Ui\AdminTable;

class RecurringTable extends AdminTable
{
    /**
     * Make table response for the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function make()
    {
        return $this->newTable()
            ->addColumn('customer_name', function ($recurring) {
                return $recurring->customer_name;
            });

        // return $this->newTable();
    }
}
