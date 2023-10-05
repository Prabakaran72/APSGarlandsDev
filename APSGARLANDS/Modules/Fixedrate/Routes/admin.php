<?php

use Illuminate\Support\Facades\Route;

Route::get('fixedrates', [
    'as' => 'admin.fixedrates.index',
    'uses' => 'FixedrateController@index',
    'middleware' => 'can:admin.fixedrates.index',
]);

Route::get('fixedrates/create', [
    'as' => 'admin.fixedrates.create',
    'uses' => 'FixedrateController@create',
    'middleware' => 'can:admin.fixedrates.create',
]);

Route::post('fixedrates', [
    'as' => 'admin.fixedrates.store',
    'uses' => 'FixedrateController@store',
    'middleware' => 'can:admin.fixedrates.create',
]);

Route::get('fixedrates/{id}/edit', [
    'as' => 'admin.fixedrates.edit',
    'uses' => 'FixedrateController@edit',
    'middleware' => 'can:admin.fixedrates.edit',
]);

Route::put('fixedrates/{id}/edit', [
    'as' => 'admin.fixedrates.update',
    'uses' => 'FixedrateController@update',
    'middleware' => 'can:admin.fixedrates.edit',
]);

Route::delete('fixedrates/{ids?}', [
    'as' => 'admin.fixedrates.destroy',
    'uses' => 'FixedrateController@destroy',
    'middleware' => 'can:admin.fixedrates.destroy',
]);
Route::get('getpincode',[
    'as' => 'admin.fixedrates.getpincode',
    'uses'=>'FixedrateController@getPincode',
    'middleware' => 'can:admin.fixedrates.index',
    ] ); // You can specify a name for the route if needed
Route::get('getfixedrates',[
     'as' => 'admin.fixedrates.getfixedrates',
     'uses'=>'FixedrateController@getFixedrates',
     'middleware' => 'can:admin.fixedrates.index',
     ]); 
