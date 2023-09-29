<?php

return [
    'admin.blogposts' => [
        'index' => 'blogpost::permissions.index',
        'create' => 'blogpost::permissions.create',
        'edit' => 'blogpost::permissions.edit',
        'destroy' => 'blogpost::permissions.destroy',
    ],
];
