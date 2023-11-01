<?php

use Illuminate\Support\Facades\Route;

Route::get('customers', [
    'as' => 'admin.customers.index',
    'uses' => 'CustomerController@index',
    'middleware' => 'can:admin.customers.index',
]);

Route::get('customers/create', [
    'as' => 'admin.customers.create',
    'uses' => 'CustomerController@create',
    'middleware' => 'can:admin.customers.create',
]);

Route::post('customers', [
    'as' => 'admin.customers.store',
    'uses' => 'CustomerController@store',
    'middleware' => 'can:admin.customers.create',
]);
Route::post('customers/country', [
    'as' => 'admin.customers.country',
    'uses' => 'CustomerController@country',
    'middleware' => 'can:admin.customers.getcountry',
]);

Route::get('customers/{id}/edit', [
    'as' => 'admin.customers.edit',
    'uses' => 'CustomerController@edit',
    'middleware' => 'can:admin.customers.edit',
]);

Route::put('customers/{id}/edit', [
    'as' => 'admin.customers.update',
    'uses' => 'CustomerController@update',
    'middleware' => 'can:admin.customers.edit',
]);

Route::delete('customers/{ids?}', [
    'as' => 'admin.customers.destroy',
    'uses' => 'CustomerController@destroy',
    'middleware' => 'can:admin.customers.destroy',
]);


Route::get('customers/{id}/show', [
    'as' => 'admin.customers.edit',
    'uses' => 'CustomerController@edit',
    'middleware' => 'can:admin.customers.edit',
]);
