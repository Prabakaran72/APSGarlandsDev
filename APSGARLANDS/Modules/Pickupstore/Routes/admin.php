<?php

use Illuminate\Support\Facades\Route;

Route::get('pickupstores', [
    'as' => 'admin.pickupstores.index',
    'uses' => 'PickupstoreController@index',
    'middleware' => 'can:admin.pickupstores.index',
]);

Route::get('pickupstores/create', [
    'as' => 'admin.pickupstores.create',
    'uses' => 'PickupstoreController@create',
    'middleware' => 'can:admin.pickupstores.create',
]);

Route::post('pickupstores', [
    'as' => 'admin.pickupstores.store',
    'uses' => 'PickupstoreController@store',
    'middleware' => 'can:admin.pickupstores.create',
]);

Route::get('pickupstores/{id}/edit', [
    'as' => 'admin.pickupstores.edit',
    'uses' => 'PickupstoreController@edit',
    'middleware' => 'can:admin.pickupstores.edit',
]);

Route::put('pickupstores/{id}/edit', [
    'as' => 'admin.pickupstores.update',
    'uses' => 'PickupstoreController@update',
    'middleware' => 'can:admin.pickupstores.edit',
]);

Route::delete('pickupstores/{ids?}', [
    'as' => 'admin.pickupstores.destroy',
    'uses' => 'PickupstoreController@destroy',
    'middleware' => 'can:admin.pickupstores.destroy',
]);
