<?php

return [
    'admin.orders' => [
        'index' => 'order::permissions.index',
        'show' => 'order::permissions.show',
        'create' => 'order::permissions.create',
        'edit' => 'order::permissions.edit',
        'destroy' => 'order::permissions.destroy',
    ],
];
