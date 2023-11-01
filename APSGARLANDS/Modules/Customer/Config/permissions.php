<?php

return [
    'admin.customers' => [
        'index' => 'customer::permissions.index',
        'create' => 'customer::permissions.create',
        'edit' => 'customer::permissions.edit',
        'destroy' => 'customer::permissions.destroy',
    ],
];
