<?php

namespace Modules\Galleries\Admin;

use Modules\Admin\Ui\AdminTable;

class GalleriesTable extends AdminTable
{
    /**
     * Raw columns that will not be escaped.
     *
     * @var array
     */
    protected $rawColumns = ['action'];

    /**
     * Make table response for the resource.
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function make()
    {
        return $this->newTable()
            ->editColumn('thumbnail', function ($file) {
                return view('galleries::admin.galleries.partials.table.thumbnail', compact('file'));
            })
            ->addColumn('action', function ($file) {
                return view('galleries::admin.galleries.partials.table.action', compact('file'));
            });
    }
}
