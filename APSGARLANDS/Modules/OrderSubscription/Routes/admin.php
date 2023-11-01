<?php

use Illuminate\Support\Facades\Route;

Route::get('categories/tree', [
    'as' => 'admin.categories.tree',
    'uses' => 'OrderSubscriptionTreeController@index',
    'middleware' => 'can:admin.ordersubscription.index',
]);

Route::put('categories/tree', [
    'as' => 'admin.categories.tree.update',
    'uses' => 'OrderSubscriptionTreeController@update',
    'middleware' => 'can:admin.ordersubscription.edit',
]);

Route::get('ordersubscription', [
    'as' => 'admin.ordersubscription.index',
    'uses' => 'OrderSubscriptionController@index',
    'middleware' => 'can:admin.ordersubscription.index',
]);

Route::post('ordersubscription', [
    'as' => 'admin.ordersubscription.store',
    'uses' => 'OrderSubscriptionController@store',
    'middleware' => 'can:admin.ordersubscription.create',
]);

Route::get('ordersubscription/{id}', [
    'as' => 'admin.ordersubscription.show',
    'uses' => 'OrderSubscriptionController@show',
    'middleware' => 'can:admin.ordersubscription.edit',
]);

Route::put('ordersubscription/{id}', [
    'as' => 'admin.ordersubscription.update',
    'uses' => 'OrderSubscriptionController@update',
    'middleware' => 'can:admin.ordersubscription.edit',
]);

Route::delete('ordersubscription/{id}', [
    'as' => 'admin.ordersubscription.destroy',
    'uses' => 'OrderSubscriptionController@destroy',
    'middleware' => 'can:admin.ordersubscription.destroy',
]);
