<?php

namespace Modules\Galleries\Eloquent;

use Modules\Galleries\Entities\Galleries;

trait HasGalleries {
    /**
     * The "booting" method of the trait.
     *
     * @return void
     */
    public static function bootHasGalleries()
    {
        static::saved(function ($entity) {
            $entity->syncFiles(request('files', []));
        });
    }
}
