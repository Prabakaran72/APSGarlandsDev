<?php

namespace Modules\Galleries\Http\Controllers\Admin;

use Modules\Galleries\Entities\Galleries;
use Illuminate\Support\Facades\Storage;
use Modules\Admin\Traits\HasCrudActions;
use Modules\Galleries\Http\Requests\UploadGalleriesRequest;

class GalleriesController
{
    use HasCrudActions;

    /**
     * Model for the resource.
     *
     * @var string
     */
    protected $model = Galleries::class;

    /**
     * Label of the resource.
     *
     * @var string
     */
    protected $label = 'galleries::galleries.galleries';

    /**
     * View path of the resource.
     *
     * @var string
     */
    protected $viewPath = 'galleries::admin.galleries';

    /**
     * Store a newly created galleries in storage.
     *
     * @param \Modules\Galleries\Http\Requests\UploadGalleriesRequest $request
     * @return \Illuminate\Http\Response
     */
    public function store(UploadGalleriesRequest $request)
    {
        $file = $request->file('file');
        $path = Storage::putFile('galleries', $file);

        return File::create([
            'user_id' => auth()->id(),
            'disk' => config('filesystems.default'),
            'filename' => $file->getClientOriginalName(),
            'path' => $path,
            'extension' => $file->guessClientExtension() ?? '',
            'mime' => $file->getClientMimeType(),
            'size' => $file->getSize(),
        ]);
    }

    /**
     * Remove the specified resources from storage.
     *
     * @param string $ids
     * @return \Illuminate\Http\Response
     */
    public function destroy($ids)
    {
        File::find(explode(',', $ids))->each->delete();
    }
}
