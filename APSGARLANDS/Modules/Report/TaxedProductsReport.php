<?php

namespace Modules\Report;

use Illuminate\Database\Eloquent\Builder;

class TaxedProductsReport extends Report {
    protected $filters = [];

    protected function view() {
        return 'report::admin.reports.taxed_products_report.index';
    }

    protected function data() {
    }

    protected function query() {
    }
}
