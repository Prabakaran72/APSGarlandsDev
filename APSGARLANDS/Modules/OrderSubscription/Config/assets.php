<?php

return [
    /*
    |--------------------------------------------------------------------------
    | Define which assets will be available through the asset manager
    |--------------------------------------------------------------------------
    | These assets are registered on the asset manager
    */
    'all_assets' => [
        'admin.ordersubscription.css' => ['module' => 'ordersubscription:admin/css/ordersubscription.css'],
        'admin.ordersubscription.js' => ['module' => 'ordersubscription:admin/js/ordersubscription.js'],
        'admin.jstree.js' => ['module' => 'ordersubscription:admin/js/jstree.js'],
    ],

    /*
    |--------------------------------------------------------------------------
    | Define which default assets will always be included in your pages
    | through the asset pipeline
    |--------------------------------------------------------------------------
    */
    'required_assets' => [],
];
