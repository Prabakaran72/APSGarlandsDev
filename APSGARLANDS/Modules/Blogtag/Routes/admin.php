<?php

use Illuminate\Support\Facades\Route;

Route::get('blogtags', [
    'as' => 'admin.blogtags.index',
    'uses' => 'BlogtagController@index',
    'middleware' => 'can:admin.blogtags.index',
]);

Route::get('blogtags/create', [
    'as' => 'admin.blogtags.create',
    'uses' => 'BlogtagController@create',
    'middleware' => 'can:admin.blogtags.create',
]);

Route::post('blogtags', [
    'as' => 'admin.blogtags.store',
    'uses' => 'BlogtagController@store',
    'middleware' => 'can:admin.blogtags.create',
]);

Route::get('blogtags/{id}/edit', [
    'as' => 'admin.blogtags.edit',
    'uses' => 'BlogtagController@edit',
    'middleware' => 'can:admin.blogtags.edit',
]);

Route::put('blogtags/{id}/edit', [
    'as' => 'admin.blogtags.update',
    'uses' => 'BlogtagController@update',
    'middleware' => 'can:admin.blogtags.edit',
]);

Route::delete('blogtags/{ids?}', [
    'as' => 'admin.blogtags.destroy',
    'uses' => 'BlogtagController@destroy',
    'middleware' => 'can:admin.blogtags.destroy',
]);
