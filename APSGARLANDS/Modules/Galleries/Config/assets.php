<?php

return [
    /*
    |--------------------------------------------------------------------------
    | Define which assets will be available through the asset manager
    | These assets are registered on the asset manager.
    |--------------------------------------------------------------------------
    */
    'all_assets' => [
        'admin.galleries.css' => ['module' => 'galleries:admin/css/galleries.css'],
        'admin.galleries.js' => ['module' => 'galleries:admin/js/galleries.js'],
    ],

    /*
    |--------------------------------------------------------------------------
    | Define which default assets will always be included in all pages
    | through the asset pipeline.
    |--------------------------------------------------------------------------
    */
    'required_assets' => [],
];
